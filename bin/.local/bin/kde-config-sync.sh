#!/usr/bin/env bash
#
# Copy files from ~/.config to current directory (which mirrors ~/.config),
# overwriting what is here. Use to refresh your backup.
# Usage:
#   ./sync-backup.sh              # sync all repo files
#   ./sync-backup.sh kwinrc       # sync only this file
#   ./sync-backup.sh --add file   # add a NEW file to the repo from ~/.config

set -u

CONFIG_DIR="$HOME/.config"
ADD_MODE=0
PATTERN="*"

# --- Parse arguments ---
while [[ $# -gt 0 ]]; do
    case "$1" in
        --add)
            ADD_MODE=1
            shift
            ;;
        -n|--dry-run)
            DRY_RUN=1
            shift
            ;;
        -h|--help)
            echo "Usage: $0 [--dry-run] [--add] [file-pattern]"
            echo "  --add       copy pattern from ~/.config even if not yet in repo"
            echo "  --dry-run   show what would be copied, don't copy"
            echo "  pattern     glob pattern to limit which files are synced"
            exit 0
            ;;
        *)
            PATTERN="$1"
            shift
            ;;
    esac
done
DRY_RUN="${DRY_RUN:-0}"

shopt -s nullglob globstar

copied=0
missing=0

# --- Add mode: pull new files from ~/.config ---
if (( ADD_MODE )); then
    for orig_file in "$CONFIG_DIR"/**/$PATTERN; do
        [[ -f "$orig_file" ]] || continue
        rel="${orig_file#"$CONFIG_DIR"/}"

        # Skip our own scripts if repo is also in .config-like layout
        [[ "$rel" == *.sh ]] && continue

        if [[ -e "$rel" ]]; then
            continue  # already tracked, handled below
        fi

        if (( DRY_RUN )); then
            echo "NEW:      $rel"
        else
            mkdir -p "$(dirname "$rel")"
            cp -v "$orig_file" "$rel"
            echo "ADDED:    $rel"
        fi
        ((copied++))
    done
fi

# --- Sync mode: refresh files already present in the repo ---
repo_files=(**/$PATTERN)

for repo_file in "${repo_files[@]}"; do
    [[ -f "$repo_file" ]] || continue
    [[ "$repo_file" == *.sh ]] && continue
    orig_file="$CONFIG_DIR/$repo_file"

    if [[ ! -e "$orig_file" ]]; then
        echo "MISSING:  ~/.config/$repo_file (skipped)" >&2
        ((missing++))
        continue
    fi

    if cmp -s "$repo_file" "$orig_file"; then
        continue  # already identical
    fi

    if (( DRY_RUN )); then
        echo "UPDATE:   $repo_file"
    else
        cp -v "$orig_file" "$repo_file"
        echo "UPDATED:  $repo_file"
    fi
    ((copied++))
done

# --- Summary ---
echo "----------------------------------------"
if (( DRY_RUN )); then
    echo "Dry run: $copied file(s) would be copied, $missing missing in ~/.config"
else
    echo "Copied $copied file(s), $missing missing in ~/.config"
fi

