# 07 - Deeply nested inputs quadratic hang

Class: HANG (super-linear CPU, no panic)
Severity: denial of service (amplification: a 19 KB file burns 25 to 30s of CPU)
Gated: no

## What it does

Before rendering, Terragrunt normalizes the resolved `inputs` value with
`ctyhelper.UpdateUnknownCtyValValues`. That function recurses through every
nesting level of the value, and at each level calls `gocty.ToCtyValue`, which in
turn calls `cty.Type.Equals` on the remaining nested type. Walking N levels and
doing O(N) type comparison at each level is O(N^2). A value nested a few thousand
levels deep takes seconds; a deeper one does not finish.

This is driven by nesting DEPTH, not size. Fifty thousand flat list elements
render in a couple of seconds; a list nested nine thousand levels deep hangs.

It is a different mechanism from the huge-exponent number hang (cases 02 to 04):
no `big.Float` is involved, the cost is cty type-equality recursion.

## Files

- `terragrunt.hcl` - `inputs = { x = [[[ ... 9500 levels ... 1 ... ]]] }`
- `main.tf` - trivial module
- `gen.sh` - regenerates `terragrunt.hcl` at any depth: `./gen.sh 9500`

## Reproduce

```bash
timeout 20 terragrunt render --json --working-dir .   # does not finish
```

Observed: killed by the timeout (exit code 124). Scaling measured on this build:

```
depth 2000  ~1.4s
depth 4000  ~4.5s
depth 6000  ~7.8s
depth 8000  ~15s
```

Roughly 3x time for each 2x depth, which is super-linear (near quadratic). The
shipped depth of 9500 does not finish within a normal timeout. `locals` nested
the same way hang under `render --json --with-metadata`.

## Root cause

`internal/ctyhelper/helper.go:96` and `:113` in `UpdateUnknownCtyValValues`:
the function recurses through the nested value (line 96), then at line 113 calls
`gocty.ToCtyValue(updatedValue, value.Type())`, whose `cty.Type.Equals`
(`cty/tuple_type.go`) recurses element by element through the entire remaining
nested type. The call site is `pkg/config/config.go` where the resolved inputs
are normalized before render serializes the config.

## Fix direction

Bound the nesting depth that `UpdateUnknownCtyValValues` will descend, returning
a typed error past a sane limit (mirroring the `MaxTraversalDepth` style cap used
elsewhere). Alternatively, avoid the per-level `ToCtyValue` re-typing so the walk
is linear in the number of nodes rather than quadratic in depth.
