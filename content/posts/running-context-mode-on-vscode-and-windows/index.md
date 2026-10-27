+++
date = '2026-10-27T18:25:00-03:00'
draft = false
title = 'Running Context Mode on VS Code and Windows'
+++

Install it from PowerShell:

```powershell
npm install -g context-mode
```

In your project, create `.vscode/mcp.json`:

```json
{
  "servers": {
    "context-mode": {
      "command": "context-mode"
    }
  }
}
```

To enable Context Mode's VS Code hooks, create `.github/hooks/context-mode.json`:

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "type": "command",
        "command": "context-mode hook vscode-copilot pretooluse"
      }
    ],
    "PostToolUse": [
      {
        "type": "command",
        "command": "context-mode hook vscode-copilot posttooluse"
      }
    ],
    "SessionStart": [
      {
        "type": "command",
        "command": "context-mode hook vscode-copilot sessionstart"
      }
    ]
  }
}
```

Reload VS Code. In Copilot Chat, send:

```text
ctx stats
```

Copilot Chat should return your Context Mode session statistics.
