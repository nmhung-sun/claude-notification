# sound-notify

A [Claude Code](https://claude.com/claude-code) plugin that plays a sound when Claude finishes a task or is waiting for you. It is language- and framework-agnostic: any project, any stack.

| Event | Sound file |
| --- | --- |
| Task complete (`Stop` hook) | `complete.mp3` |
| Waiting for your approval (`Notification`, `permission_prompt`) | `wait-for-approval.mp3` |
| Idle, waiting for your input (`Notification`, `idle_prompt`) | `wait-for-approval.mp3` |

## Presets

Pick a sound set with the `preset` option:

| Preset | Description |
| --- | --- |
| `default` | The original pair |
| `bong` | Bong sounds |
| `meme` | Meme sounds |

Claude Code asks for it when you enable the plugin. Change it later in the `/config` panel (needs Claude Code 2.1.271 or newer), or set it in your user-level `~/.claude/settings.json` (project and local settings files ignore plugin options):

```json
{ "pluginConfigs": { "sound-notify@nmhung-sun": { "options": { "preset": "bong" } } } }
```

An unknown or missing preset falls back to `default`.

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

In a fork, add a folder under `sounds/` containing `complete.mp3` and `wait-for-approval.mp3`, then add its name to `options` in `.claude-plugin/plugin.json`. To change which events play which sound, edit `hooks/hooks.json`: `play-sound.sh <name>` plays `sounds/<preset>/<name>.mp3`.

## Releasing (maintainers)

1. Bump `version` in `.claude-plugin/plugin.json` and add a `CHANGELOG.md` entry.
2. Commit, then `git tag 1.0.1 && git push --tags`.
3. Create a GitHub release for the tag.

Run `claude plugin validate .` before tagging.
