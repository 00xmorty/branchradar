# BranchRadar

BranchRadar is a tiny, dependency-free, read-only CLI that sorts local Git branches by their last commit and shows age, merge status against a chosen base, and upstream ahead/behind counts.

## Run

Requires Git and Python 3.9+ on macOS or Linux.

```sh
curl -LO https://github.com/00xmorty/branchradar/releases/latest/download/branchradar
chmod +x branchradar
cd /path/to/your/repo
/path/to/branchradar
```

Or clone and run `./branchradar` inside any Git work tree.

```text
CUR  AGE  MERGED->HEAD  A/B    BRANCH (UPSTREAM)
*      0d  yes     1/0    feature (origin/feature)
      42d  yes     -      old-experiment

2 local branch(es). Read-only: nothing changed.
```

Use `--stale-days 30` to filter by age or `--json` for automation. Version 0.2.0 can compare merge ancestry against an explicit local base ref without checking it out:

```sh
./branchradar --base main
./branchradar --base origin/main --json
```

The ref must already exist locally. BranchRadar never fetches it.

## Safety

- Strictly read-only: invokes only Git inspection commands.
- Never checks out, merges, deletes, prunes, fetches, pushes, or edits branches/files.
- No `sudo`, network requests, telemetry, or credentials.
- Review output and use native Git commands yourself if you decide to change anything.

## Limitations

- `merged` means reachable from `HEAD` or the ref supplied with `--base`; it is not proof that a branch is safe to delete.
- Ahead/behind is calculated only for an existing local upstream-tracking reference. BranchRadar does not fetch, so remote state may be stale.
- Squash/rebase merges may appear unmerged because commit ancestry changed.
- Commit age is not the same as branch creation age; Git does not reliably store branch creation time.
- Only local branches are listed. Run it separately in each work tree/repository.

## Development

```sh
bash tests/test.sh
```

## License

MIT
