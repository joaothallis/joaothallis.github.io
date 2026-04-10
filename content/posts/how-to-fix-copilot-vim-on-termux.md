---
title: "How to Fix Copilot.vim on Termux"
date: 2026-04-10T12:00:00-03:00
draft: false
---

If you've tried using [copilot.vim](https://github.com/github/copilot.vim) on Termux and hit this error when running `:Copilot auth`:

```
Copilot: Process exited with status 127
```

Here's why it happens and how to fix it.

## The Problem

Copilot.vim uses `npx` to download and run `@github/copilot-language-server`. That package ships native binaries for macOS, Linux, and Windows — but not for Android. When `npx` tries to execute the `copilot-language-server` binary on Termux, the system can't find a compatible executable, resulting in exit code 127 (command not found).

The good news is the package also includes a `language-server.js` file that runs perfectly fine with Node.js. We just need to tell Copilot to use it directly instead of going through `npx`.

## The Fix

### 1. Install the language server globally

```bash
npm install -g @github/copilot-language-server
```

### 2. Configure Neovim

Add the following to your `init.lua`, **before** loading the copilot.vim plugin:

```lua
vim.g.copilot_node_command = '/data/data/com.termux/files/usr/bin/node'
vim.g.copilot_command = '/data/data/com.termux/files/usr/lib/node_modules/@github/copilot-language-server/dist/language-server.js'
```

This tells Copilot to skip `npx` entirely and run the JS entrypoint directly with Node.

### 3. Authenticate

Restart Neovim and run:

```vim
:Copilot auth
```

It should now connect successfully and prompt you to authenticate with GitHub.
