# sound-notify

A [Claude Code](https://claude.com/claude-code) plugin that plays a sound when Claude finishes a task or is waiting for you. It is language- and framework-agnostic: any project, any stack.

| Event | Sound |
| --- | --- |
| Task complete (`Stop` hook) | `complete.mp3` |
| Waiting for your approval (`Notification`, `permission_prompt`) | `wait-for-approval.mp3` |
| Idle, waiting for your input (`Notification`, `idle_prompt`) | `wait-for-approval.mp3` |

## Install

```bash
claude plugin marketplace add nmhung-sun/claude-notification
claude plugin install sound-notify@nmhung-sun
```

Or from inside Claude Code: `/plugin marketplace add nmhung-sun/claude-notification`, then `/plugin install sound-notify@nmhung-sun`.

To pin a release tag, add the marketplace with the tag:

```bash
claude plugin marketplace add nmhung-sun/claude-notification@1.0.0
```

To share it with a team, add `--scope project` so it is declared in the project's `.claude/settings.json`.

Update with `claude plugin update sound-notify@nmhung-sun`.

## Requirements

| OS | Needs |
| --- | --- |
| macOS | nothing (`afplay` is built in) |
| Windows | `sh` available, which Git for Windows provides; uses PowerShell for playback |
| Linux | one of `mpg123`, `ffplay`, `mpv`, `cvlc`, `paplay` |

If no player is found, the hook does nothing and never blocks Claude.

## Customize

Replace the files in `sounds/` (keep the names) in a fork, or edit `hooks/hooks.json` to change which events play which sound. Sounds are referenced by file name without extension: `play-sound.sh <name>` plays `sounds/<name>.mp3`.

## Releasing (maintainers)

1. Bump `version` in `.claude-plugin/plugin.json` and add a `CHANGELOG.md` entry.
2. Commit, then `git tag 1.0.1 && git push --tags`.
3. Create a GitHub release for the tag.

Run `claude plugin validate .` before tagging.
