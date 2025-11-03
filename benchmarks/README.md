# Quick Terragrunt Performance Benchmarking

Quick guide for comparing performance between the development version and release.

## Quick Start

### Option 1: Quick Single Test (using `time` command)

```bash
# Quick test with default fixture (dependency-output)
./benchmark-quick.sh

# Test specific fixture
FIXTURE=./test/fixtures/auth-provider-parallel ./benchmark-quick.sh

# Test specific command
COMMAND="find" ./benchmark-quick.sh

# Test with custom binaries
DEV_BINARY=./terragrunt RELEASE_BINARY=/usr/local/bin/terragrunt ./benchmark-quick.sh
```

### Option 2: Comprehensive Comparison (multiple runs, statistics)

```bash
# Run 5 benchmarks (default: 5 runs each)
./benchmark-compare.sh

# Run more iterations for more accurate results
RUNS=10 ./benchmark-compare.sh

# Use custom fixture directory
FIXTURE_DIR=./test/fixtures ./benchmark-compare.sh
```

## Benchmark Scripts

### `benchmark-quick.sh`
- **Fast**: Single run per version
- **Simple**: Uses standard `time` command
- **Good for**: Quick spot checks, manual testing
- **Customizable via env vars**: `FIXTURE`, `COMMAND`, `DEV_BINARY`, `RELEASE_BINARY`

### `benchmark-compare.sh`
- **Comprehensive**: Multiple runs with statistics (avg, min, max)
- **Multiple tests**: Runs 5 different benchmark scenarios
- **Accurate**: Averages multiple runs to reduce noise
- **Comparison**: Shows percentage difference between versions
- **Customizable via env vars**: `RUNS`, `FIXTURE_DIR`, `DEV_BINARY`, `RELEASE_BINARY`

## Benchmark Scenarios

The comprehensive script (`benchmark-compare.sh`) tests:

1. **Find Command** - Discovery performance
2. **Run --all Plan** - Execution with dependency resolution
3. **HCL Show** - Configuration parsing performance
4. **DAG** - Dependency graph generation
5. **Auth Provider Parallel** - Parallel execution in runner pool

## Example Output

### Quick Benchmark
```
[DEV (this branch)] Running: ./terragrunt run --all --non-interactive -- plan

real    0m2.456s
user    0m1.234s
sys     0m0.567s

[RELEASE (v0.93.0)] Running: /home/denis256/bin/terragrunt run --all --non-interactive -- plan

real    0m2.789s
user    0m1.456s
sys     0m0.623s
```

### Comprehensive Benchmark
```
1. Find Command (Simple Discovery)
  Dev (this branch):
    Avg:   1234 ms  |  Min:   1189 ms  |  Max:   1278 ms
  Release (v0.93.0):
    Avg:   1456 ms  |  Min:   1401 ms  |  Max:   1512 ms
  Faster by 15.24% (-222ms)
```

## Interpreting Results

- **Negative %** = Development version is **faster** ✅
- **Positive %** = Development version is **slower** ⚠️
- **< 5% difference** = Likely within measurement noise
- **> 10% difference** = Significant performance change

## Tips

1. **Warm up**: Run each version once before benchmarking to ensure caches are warm
2. **Clean environment**: Close other applications to reduce system noise
3. **Multiple runs**: Use `RUNS=10` or higher for more reliable results
4. **Consistent state**: Scripts automatically clean `.terragrunt-cache` between runs
5. **Focus on avg times**: Min/max can vary due to system noise

## Advanced Usage

### Test Custom Fixture

```bash
# Create your own fixture
mkdir -p /tmp/my-benchmark
# ... set up terragrunt configs ...

# Test with quick script
FIXTURE=/tmp/my-benchmark COMMAND="run --all -- plan" ./benchmark-quick.sh

# Or comprehensive
FIXTURE_DIR=/tmp ./benchmark-compare.sh
```

### Test Specific Commands

```bash
# Test discovery performance
COMMAND="find" ./benchmark-quick.sh

# Test graph generation
COMMAND="dag --working-dir ." ./benchmark-quick.sh

# Test validation
COMMAND="run --all --non-interactive -- validate" ./benchmark-quick.sh
```

### Compare Different Branches

```bash
# Build dev version
go build -o terragrunt-dev

# Build another branch
git checkout feature-branch
go build -o terragrunt-feature

# Compare them
DEV_BINARY=./terragrunt-dev RELEASE_BINARY=./terragrunt-feature ./benchmark-compare.sh
```

## Benchmarking Best Practices

1. **Close unnecessary apps**: Free up CPU and memory
2. **Disable CPU throttling**: Ensure consistent CPU performance
3. **Run multiple times**: Average across multiple runs (5-10 is good)
4. **Test on same hardware**: Don't compare results from different machines
5. **Test realistic scenarios**: Use fixtures that match your use case
6. **Check for outliers**: If one run is much slower, system might have been busy

## Environment Variables Reference

| Variable | Default | Description |
|----------|---------|-------------|
| `DEV_BINARY` | `./terragrunt` | Path to development binary |
| `RELEASE_BINARY` | `/home/denis256/bin/terragrunt` | Path to release binary |
| `FIXTURE` | `./test/fixtures/dependency-output` | Fixture for quick script |
| `FIXTURE_DIR` | `./test/fixtures` | Fixture directory for comprehensive script |
| `COMMAND` | `run --all --non-interactive -- plan` | Terragrunt command to benchmark |
| `RUNS` | `5` | Number of runs per benchmark (comprehensive only) |

## Troubleshooting

**Binary not found**: Set correct path with `DEV_BINARY` or `RELEASE_BINARY`
**Permission denied**: Run `chmod +x benchmark-*.sh`
**Fixture not found**: Use `FIXTURE` or `FIXTURE_DIR` to specify valid path
**Inconsistent results**: Increase `RUNS` or close other applications
