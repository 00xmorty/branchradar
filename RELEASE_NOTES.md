# BranchRadar v0.2.0

Choose the merge comparison target without checking it out.

- Add `--base REF` to compare local branch ancestry against `main`, `origin/main`, or another existing local commit ref.
- Validate the selected base and fail clearly instead of silently reporting misleading merge state.
- Include `base_ref` and `merged_into_base` in JSON output and the selected ref in the text header.
- Remain strictly read-only: no fetch, checkout, delete, prune, or file changes.
- Tested on macOS and Linux with Python 3.9+ and Git.
