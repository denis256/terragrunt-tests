# 02 - Inputs huge-exponent number hang

Class: HANG (resource exhaustion, no panic, never returns in practical time)
Severity: denial of service
Gated: no, works on a default install

## What it does

A number literal with an enormous exponent such as `9E9999999` parses lazily,
so the HCL parse returns instantly. The cost is paid later, when go-cty
materializes the value into a `big.Float` and formats it to a full decimal
string with millions of digits. That formatting is super-linear and does not
return in practical time.

This case puts the literal in an `inputs` value. `terragrunt render` serializes
the resolved inputs, which forces the number-to-decimal conversion and hangs.
No OpenTofu is required since the hang is at config render time.

## Files

- `terragrunt.hcl` - `inputs = { count = 9E9999999 }`
- `main.tf` - a trivial module so the unit is loadable

## Reproduce

```bash
timeout 20 terragrunt render --working-dir .   # does not finish, killed by timeout
```

To see the scaling instead of an open-ended hang, lower the exponent:

```bash
# 9E2000000 finishes in roughly ten seconds and shows the cost is real
```

Observed: the command burns CPU and memory and never returns. Without a memory
limit it is killed by the timeout (exit code 124). With a memory limit such as
`GOMEMLIMIT=2GiB` it is killed by the out-of-memory killer first (exit code
137). Both outcomes are the same denial of service. With a moderate exponent
like `9E2000000` it completes in about ten seconds using over one hundred
megabytes of resident memory, which shows the cost is real and super-linear.

## Root cause

go-cty number to string conversion at
`zclconf/go-cty/cty/convert/conversion_primitive.go` uses `f.Text('f', -1)`,
which emits full positional decimal notation. For `9E<N>` that is about `N`
digits, and the `big.Float` decimal formatting is roughly quadratic in `N`.

## Fix direction

Bound the magnitude of a numeric literal before it is coerced to a string, at
the Terragrunt evaluation boundary. Reject or clamp a number whose binary
exponent exceeds a small cap with a typed error. Worth reporting upstream to
go-cty as well, since the safe conversion is itself unbounded.
