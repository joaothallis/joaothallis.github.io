# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Personal blog built with **Hugo** using the **Congo v2** theme (custom fork: `github.com/joaothallis/congo/v2`). Deployed to GitHub Pages at joaothallis.com.

## Commands

```bash
# Development server (includes drafts)
hugo server -D

# Production build
hugo --minify

# Create a new post
hugo new content/posts/<post-name>.md

# Enter Nix dev environment (provides Hugo + Go)
nix develop --extra-experimental-features "nix-command flakes"

# Update Hugo modules (theme)
hugo mod get -u
```

## Architecture

- **Config**: Split across `config/_default/` (params, languages, menus, modules, markup) with root `hugo.toml` for base settings
- **Content**: All posts in `content/posts/`, standalone pages in `content/` root (e.g., `about.md`)
- **Theme**: Congo v2 imported via Hugo modules (go.mod), not the `themes/` directory. Custom fork allows theme modifications upstream
- **Layouts**: Currently empty — all rendering uses the Congo theme defaults. Override by adding files matching theme layout paths
- **Deployment**: GitHub Actions (`.github/workflows/gh-pages.yml`) builds with Hugo v0.158.0 extended and deploys to GitHub Pages
- **Dev Environment**: Nix flakes (`flake.nix`) with direnv (`.envrc`) for reproducible tooling
