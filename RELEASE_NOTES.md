# BranchRadar v0.1.0

Initial public release.

- Sort local branches by last commit date.
- Show age, current branch, merge-into-HEAD status, and upstream ahead/behind counts.
- Support `--stale-days N` and machine-readable `--json` output.
- Remain strictly read-only: no fetch, checkout, delete, prune, or file changes.
- Tested on macOS and Linux with Python 3.9+ and Git.
