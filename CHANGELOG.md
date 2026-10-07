# Changelog

## [1.1.0]

- Sound presets: new `preset` option (`default`, `bong`, `meme`). Sounds moved to `sounds/<preset>/`.
- Falls back to `default` for an unknown preset.

## [1.0.0]

- Initial release as a Claude Code plugin (`sound-notify`).
- `Stop` plays `complete.mp3`; `Notification` (`permission_prompt` and `idle_prompt`) plays `wait-for-approval.mp3`.
- Works on macOS, Windows and Linux.
