#!/usr/bin/env bash
set -euo pipefail
root="$(cd "$(dirname "$0")/.." && pwd)"
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT
git -C "$tmp" init -q
git -C "$tmp" config user.name Test
git -C "$tmp" config user.email test@example.invalid
printf 'base\n' > "$tmp/file.txt"
git -C "$tmp" add file.txt
git -C "$tmp" commit -qm base
git -C "$tmp" branch merged
git -C "$tmp" checkout -qb work
printf 'work\n' >> "$tmp/file.txt"
git -C "$tmp" commit -qam work
python3 -m py_compile "$root/branchradar"
(cd "$tmp" && python3 "$root/branchradar" > report.txt)
grep -q 'Read-only: nothing changed' "$tmp/report.txt"
grep -q 'work' "$tmp/report.txt"
(cd "$tmp" && python3 "$root/branchradar" --json > report.json)
python3 - "$tmp/report.json" <<'PY'
import json, sys
r = json.load(open(sys.argv[1], encoding='utf-8'))
assert r['read_only'] is True
assert {b['branch'] for b in r['branches']} >= {'work', 'merged'}
assert next(b for b in r['branches'] if b['branch'] == 'work')['current'] is True
PY
(cd "$tmp" && python3 "$root/branchradar" --stale-days 9999 > stale.txt)
grep -q '0 local branch(es)' "$tmp/stale.txt"
python3 "$root/branchradar" --version | grep -q '0.1.0'
echo 'PASS: syntax, fixture repository, JSON, stale filter, safety smoke'
