#!/usr/bin/env bash
set -euo pipefail

# Usage:
#   ./scripts/install-hooks.sh                 # current repo
#   ./scripts/install-hooks.sh /path/to/repo   # specific repo

repo_path="${1:-$(pwd)}"
hooks_path_rel=".shared-hooks/hooks"

if [[ ! -d "${repo_path}/.git" ]]; then
  echo "ERROR: ${repo_path} is not a git repository." >&2
  exit 1
fi

if [[ ! -f "${repo_path}/${hooks_path_rel}/pre-push" ]]; then
  echo "ERROR: Missing ${hooks_path_rel}/pre-push in ${repo_path}." >&2
  echo "Add this repo as a submodule first:" >&2
  echo "  git submodule add <git-hooks-repo-url> .shared-hooks" >&2
  exit 1
fi

git -C "${repo_path}" config core.hooksPath "${hooks_path_rel}"
echo "Configured ${repo_path}: core.hooksPath=${hooks_path_rel}"
