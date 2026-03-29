---
title: "How to Install Neovim 0.12 (Nightly) on Termux"
date: 2026-03-23T23:10:06-03:00
draft: false
---

Neovim is evolving at a breakneck pace, and some of the most anticipated features often land in the nightly builds long before a stable release. If you're like me and want to stay on the absolute bleeding edge (currently v0.12.0-dev), this guide will show you how to get it running on your Android device via Termux.

There are two main ways to go about this: the easy way (using the `unstable-repo`) and the manual way (building from source).

## The Easy Way: Using the Unstable Repository

The Termux community maintains a nightly package that is updated frequently. This is the fastest way to get version 0.12 without having to wait for a build on your device.

### 1. Enable the Unstable Repository

First, you need to tell `pkg` to look into the community's unstable repository:

```bash
pkg install unstable-repo
pkg update
```

### 2. Install Neovim Nightly

Now, you can install the `neovim-nightly` package. Note that this package conflicts with the standard `neovim` package, so it will automatically replace it:

```bash
pkg install neovim-nightly
```

### 3. Verify the Installation

Check that everything is working as expected:

```bash
nvim --version
```

You should see something like `NVIM v0.12.0-dev`.

---

## The Bleeding Edge: Building from Source

If you want to track the `master` branch precisely or the package isn't updated as quickly as you'd like, you can build Neovim directly on your device.

### 1. Install Build Dependencies

You'll need a full build environment and some libraries:

```bash
pkg install -y build-essential cmake git gettext libtool-bin \
  libuv libmsgpack libunibilium libiconv \
  lua51-lpeg luajit tree-sitter tree-sitter-parsers utf8proc
```

### 2. Clone the Repository

```bash
git clone https://github.com/neovim/neovim.git
cd neovim
```

### 3. Build and Install

To ensure a clean build, it's best to run `make distclean` first. Then, we build for Release:

```bash
make distclean
make CMAKE_BUILD_TYPE=Release
make CMAKE_INSTALL_PREFIX=$PREFIX install
```

*Note: The `CMAKE_INSTALL_PREFIX=$PREFIX` part is important in Termux to ensure it installs into the correct userland directory.*

## Conclusion

Whether you choose the quick package install or the manual build, you're now equipped with the latest and greatest Neovim has to offer. 

Happy editing in the future!
