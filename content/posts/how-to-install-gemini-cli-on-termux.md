---
title: "How to install Gemini CLI on Termux"
date: 2026-03-22T10:00:00-03:00
draft: false
---

In this post, I will show you how to install the Gemini CLI on Termux. This is a great way to have an AI assistant right in your pocket.

First, make sure your Termux packages are up to date:

```bash
pkg update && pkg upgrade -y
```

Next, install Node.js:

```bash
pkg install nodejs -y
```

Now, you can install the Gemini CLI using npm. We use the `--ignore-scripts` flag to avoid issues with some dependencies on Termux:

```bash
npm install -g @google/gemini-cli --ignore-scripts
```

Now you can start using Gemini CLI by simply typing:

```bash
gemini
```
