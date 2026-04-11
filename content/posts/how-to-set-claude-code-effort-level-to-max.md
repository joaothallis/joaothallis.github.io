---
title: "How to Set Claude Code Effort Level to Max"
date: 2026-04-11T10:00:00-03:00
draft: false
---

By default, Claude Code starts with medium reasoning effort. You can bump it up to max for deeper, more thorough responses.

You might try setting `effortLevel` in `~/.claude/settings.json`:

```json
{
  "effortLevel": "max"
}
```

But this won't work — `settings.json` only accepts `low`, `medium`, or `high`. The `max` level is only available through the CLI flag or an environment variable.

## The Fix

Add this to your `~/.bashrc` (or `~/.zshrc`):

```bash
export CLAUDE_CODE_EFFORT_LEVEL=max
```

Then reload your shell:

```bash
source ~/.bashrc
```

The environment variable takes precedence over `settings.json` and supports all values: `low`, `medium`, `high`, and `max`.

## Other Ways to Change Effort

You can also change it per session without persisting:

- **CLI flag**: `claude --effort max`
- **In-session command**: `/effort max`

But the environment variable is the simplest way to make `max` the default across all sessions.
