# How to know OCI layers use CAS

When the `oci` experiment is enabled, `oci://` module downloads go through Content
Addressable Storage (CAS): the module tree is cached by its manifest digest, so a
repeated fetch of the same tag or digest is served from the local store instead of
re-downloaded from the registry.

There are three independent signals that prove it. Run `./05-cas-evidence.sh` to
observe all three, or check each one manually as below.

## Signal 1: Terragrunt debug log

Run any `oci://` plan with `TG_LOG_LEVEL=debug`. Two lines appear per download:

```
DEBUG  CAS enabled: attempting to use Content Addressable Storage for source: oci://127.0.0.1:5443/modules/vpc?tag=1.0.0
DEBUG  Successfully downloaded source using CAS: oci://127.0.0.1:5443/modules/vpc?tag=1.0.0
```

- The first line means the source was routed into the CAS path (only happens when the
  `oci` experiment is on; without it, neither line appears and the standard getter runs).
- The second line means CAS served the request, whether from a cold fetch or a cache hit.

## Signal 2: Registry traffic (the decisive proof)

Count the registry's own access log (`docker logs oci-e2e-registry`). Two request
kinds matter for the `modules/vpc` repository:

- `GET  /v2/modules/vpc/blobs/<digest>`  = the actual layer download.
- `HEAD /v2/modules/vpc/manifests/1.0.0` = one tag re-resolution (a probe).

Observed across a cold run then a warm run of the same tag:

| Run | blob GETs (layer download) | tag HEADs (re-resolution) |
|---|---:|---:|
| Cold (digest not in CAS) | +1 | +2 |
| Warm (same digest in CAS) | **+0** | **+1** |

The warm run downloads **zero** layer bytes: the layer is served from CAS. It still
issues a tag HEAD, because the tag is re-resolved to its manifest digest on every run.
That re-resolution is the correctness guarantee: if the tag is re-pushed to new content,
its digest changes, the CAS key changes, and the new layer is fetched instead of a stale
one being served.

The cold run issues two tag HEADs, not one: the CAS probe resolves the tag to check for a
cached entry, and the fetch path resolves it again to pin the download to that exact
digest, so a tag moving mid-download can never be stored under the wrong key. The warm run
short-circuits on the probe hit before the fetch path runs, so it resolves only once.

A digest-pinned source (`?digest=sha256:...`) makes even the tag HEAD disappear on a
warm run, because a digest is already the cache key and needs no resolution.

## Signal 3: The CAS store on disk

The layer and tree objects land in the global CAS store, keyed by content:

```
~/.cache/terragrunt/cas/store/
  blobs/   <- module file contents, content-addressed
  trees/   <- directory trees, keyed by the oci-manifest digest
```

After a cold fetch, `blobs/` and `trees/` gain the objects for that manifest. A warm
fetch reads them back and writes nothing new.

## What a regression would look like

- Warm run shows a non-zero blob-GET delta: the layer is being re-downloaded, so CAS is
  not serving OCI (caching broken).
- Warm run shows a zero tag-HEAD delta: the tag is not re-resolved, so a re-pushed tag
  could serve stale content (the mutable-tag guarantee is broken).
- Neither debug line appears with the experiment enabled: the source never entered the
  CAS path (dispatch wiring broken).

`./05-cas-evidence.sh` asserts all three and fails loudly if any regresses.
