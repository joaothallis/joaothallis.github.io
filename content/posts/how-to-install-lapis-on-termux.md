---
title: "How to Install Lapis on Termux"
date: 2026-03-23T10:00:00-03:00
draft: false
---

Lapis is a powerful framework for building web applications in Lua or MoonScript, specifically designed to run on top of OpenResty. In this post, I'll show you how to install it on Termux, including how to overcome a common compilation error with the `luaossl` dependency.

## Prerequisites

Before we begin, ensure you have OpenResty installed. If you haven't yet, check out my post on [How to Install OpenResty on Termux (Natively)](/posts/how-to-install-openresty-on-termux-natively/).

You'll also need `luarocks` and a build environment:

```bash
pkg install lua54 luarocks build-essential openssl
```

## The Challenge: Compiling luaossl

When trying to install Lapis via LuaRocks on Termux, you might encounter a build error while compiling `luaossl`. The error typically looks like this:

```text
src/openssl.c:1015:6: error: incompatible pointer to integer conversion initializing 'int' with an expression of type 'char * _Nonnull' [-Wint-conversion]
 1015 |         int rv = strerror_r(error, dst, lim);
```

This happens because the Android (Bionic) C library provides a GNU-style `strerror_r` (which returns a `char *`) instead of the XSI-compliant version (which returns an `int`) when `_GNU_SOURCE` is defined.

## The Solution: Patching luaossl

To fix this, we need to download the `luaossl` source, patch its feature detection, and install it manually.

### 1. Download and Unpack

```bash
luarocks download luaossl
luarocks unpack luaossl-*.src.rock
cd luaossl-20250929-0/luaossl-rel-20250929
```

### 2. Patch the Configuration

We need to modify `config.h.guess` to correctly identify the `strerror_r` return type for Bionic. Open `config.h.guess` and find the `STRERROR_R_CHAR_P` definition. Update it to include `defined(__BIONIC__)`:

```c
#ifndef STRERROR_R_CHAR_P
#define STRERROR_R_CHAR_P ((AG_GLIBC_PREREQ(0,0) || AG_UCLIBC_PREREQ(0,0,0) || defined(__BIONIC__)) && (HAVE__GNU_SOURCE || !(_POSIX_C_SOURCE >= 200112L || _XOPEN_SOURCE >= 600)))
#endif
```

### 3. Build and Install

Now, run `luarocks make` from within that directory:

```bash
luarocks make
```

This will compile and install the patched `luaossl` module.

## Installing Lapis

With `luaossl` successfully installed, you can now install Lapis without any issues:

```bash
luarocks install lapis
```

## Verifying the Installation

You can verify that Lapis is correctly installed by running:

```bash
lapis help
```

And to ensure `luaossl` is working:

```bash
lua -e "local openssl = require('openssl'); print(openssl.VERSION_TEXT)"
```

Happy coding with Lapis on Termux!
