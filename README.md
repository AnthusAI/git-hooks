# git-hooks

Shared Git hooks for repositories that use Conventional Commit messages and Kanbus artifact safeguards.

## Included hooks

- `hooks/commit-msg`: Enforces semantic-release / Conventional Commits subject format.
- `hooks/pre-push`: Blocks push when `project/issues` or `project/events` files are modified but uncommitted.

## `commit-msg` policy

Accepted subject format:

```text
<type>(optional-scope)!: <description>
```

Allowed types:

- `build`
- `chore`
- `ci`
- `docs`
- `feat`
- `fix`
- `perf`
- `refactor`
- `revert`
- `style`
- `test`

Examples:

- `feat(evaluations): add confusion-matrix export`
- `fix(tests): align feedback upsert expectations`
- `chore(hooks): harden pre-push path fallback`

Also allowed:

- `Merge ...`
- `Revert "..."`
- `fixup! ...` / `squash! ...`

## Install in another repository (recommended: submodule)

From the target repository:

```bash
git submodule add <git-hooks-repo-url> .shared-hooks
git config core.hooksPath .shared-hooks/hooks
```

Verify:

```bash
git config --get core.hooksPath
# expected: .shared-hooks/hooks
```

## Bootstrap helper

This repo includes a helper script:

```bash
.shared-hooks/scripts/install-hooks.sh
```

Or run from this repo:

```bash
./scripts/install-hooks.sh /path/to/target-repo
```

This sets:

- `core.hooksPath=.shared-hooks/hooks`

## Updating hooks in consuming repos

In each consuming repository:

```bash
git submodule update --remote --merge .shared-hooks
git add .shared-hooks
git commit -m "chore(hooks): update shared git hooks"
```

## Notes

- Hooks run locally and can be bypassed with `--no-verify`.
- If `rg` is unavailable in hook PATH, `pre-push` automatically falls back to `grep -E`.
- Add CI checks for defense in depth; hooks should not be your only enforcement layer.
