#!/usr/bin/env bash
#
# Compare files in current directory against the originals in ~/.config.
# Assumes current directory mirrors the ~/.config structure.
# Usage:
#   ./check-diffs.sh              # diff all files
#   ./check-diffs.sh kwinrc       # diff only this file
#   ./check-diffs.sh -q           # quiet: only report which files differ

set -u

CONFIG_DIR="$HOME/.config"
QUIET=0
PATTERN="*"

# --- Parse arguments ---
while [[ $# -gt 0 ]]; do
    case "$1" in
        -q|--quiet)
            QUIET=1
            shift
            ;;
        -h|--help)
            echo "Usage: $0 [-q] [file-pattern]"
            echo "  -q         Only list files that differ, no diff output"
            echo "  pattern    Glob pattern to limit which files are checked"
            exit 0
            ;;
        *)
            PATTERN="$1"
            shift
            ;;
    esac
done

# --- Collect files in current dir (mirroring .config layout) ---
shopt -s nullglob globstar

repo_files=(**/$PATTERN)

if [[ ${#repo_files[@]} -eq 0 ]]; then
    echo "No files matching '$PATTERN' in $(pwd)" >&2
    exit 1
fi

changed=0
missing=0

for repo_file in "${repo_files[@]}"; do
    [[ -f "$repo_file" ]] || continue
    orig_file="$CONFIG_DIR/$repo_file"

    # Skip the script itself if it lives in the repo
    [[ "$repo_file" == *.sh ]] && continue

    if [[ ! -e "$orig_file" ]]; then
        echo "MISSING: ~/$repo_file does not exist in ~/.config" >&2
        ((missing++))
        continue
    fi

    if ! cmp -s "$repo_file" "$orig_file"; then
        ((changed++))
        if (( QUIET )); then
            echo "CHANGED: $repo_file"
        else
            echo "=== $repo_file ==="
            diff -u --color=auto "$repo_file" "$orig_file" | \
                sed -e "s|$repo_file|a/$repo_file|" -e "s|$orig_file|b/$repo_file|"
            echo
        fi
    fi
done

# --- Summary ---
echo "----------------------------------------"
echo "Checked ${#repo_files[@]} files: $changed changed, $missing missing in ~/.config"

if (( changed > 0 )); then
    exit 1
else
    echo "All files are in sync."
    exit 0
fi

