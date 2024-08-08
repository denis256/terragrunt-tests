# performance tests scripts, v2

Requirements:
* htyperfine
* jq
* python3

Workflow:
* update versions.sh
* run download-files.sh
* code-init.sh
* update run-all-tests.sh


Check results in `results` directory and combined_results.json

```
python3 hyperfine/scripts/plot_histogram.py  combined_results.json
```
