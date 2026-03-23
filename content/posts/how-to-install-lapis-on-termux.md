---
title: "How to Install Lapis on Termux"
date: 2026-03-23T10:00:00-03:00
draft: false
---

Lapis is a powerful framework for building web applications in Lua or MoonScript, specifically designed to run on top of OpenResty. In this post, I'll show you how to install it on Termux, including how to overcome a common compilation error with the `luaossl` dependency and how to properly configure your environment for OpenResty.

## Prerequisites

Before we begin, ensure you have OpenResty installed. If you haven't yet, check out my post on [How to Install OpenResty on Termux (Natively)](/posts/how-to-install-openresty-on-termux-natively/).

Since OpenResty uses LuaJIT (which is compatible with Lua 5.1), we need to install our dependencies for the 5.1 version.

You'll also need `luarocks` and a build environment:

```bash
pkg install lua51 luarocks build-essential openssl
```

## The Challenge: Compiling luaossl

When trying to install Lapis via LuaRocks on Termux, you might encounter a build error while compiling `luaossl`. The error typically looks like this:

```text
src/openssl.c:1015:6: error: incompatible pointer to integer conversion initializing 'int' with an expression of type 'char * _Nonnull' [-Wint-conversion]
 1015 |         int rv = strerror_r(error, dst, lim);
```

This happens because the Android (Bionic) C library provides a GNU-style `strerror_r` (which returns a `char *`) instead of the XSI-compliant version (which returns an `int`) when `_GNU_SOURCE` is defined.

## The Solution: Patching luaossl

To fix this, we need to download the `luaossl` source, patch it, and install it manually for Lua 5.1.

### 1. Download and Unpack

```bash
luarocks --lua-version=5.1 download luaossl
luarocks --lua-version=5.1 unpack luaossl-*.src.rock
cd luaossl-20250929-0/luaossl-rel-20250929
```

### 2. Patch the Source

We need to modify `src/openssl.c` to correctly handle the `strerror_r` return type on Android. Open `src/openssl.c`, find the `aux_strerror_r` function (around line 1015), and update the `#elif` condition to include `defined(__ANDROID__)`:

```c
// Change this:
#elif STRERROR_R_CHAR_P
// To this:
#elif STRERROR_R_CHAR_P || defined(__ANDROID__)
```

### 3. Build and Install

Now, run `luarocks make` ensuring you specify the Lua version:

```bash
luarocks --lua-version=5.1 make
```

## Installing Lapis and Dependencies

With `luaossl` successfully installed, you can now install Lapis and its other required dependencies for Lua 5.1:

```bash
luarocks --lua-version=5.1 install luasocket
luarocks --lua-version=5.1 install pgmoon
luarocks --lua-version=5.1 install lapis
```

## Configuration for OpenResty

To run Lapis on OpenResty in Termux, you need two more critical steps.

### 1. Update nginx.conf

You must tell OpenResty where to find the Lua modules you installed via LuaRocks. Add these lines to the `http` block of your `nginx.conf`:

```nginx
http {
    # ... other config ...
    lua_package_path "/data/data/com.termux/files/home/.luarocks/share/lua/5.1/?.lua;/data/data/com.termux/files/home/.luarocks/share/lua/5.1/?/init.lua;;";
    lua_package_cpath "/data/data/com.termux/files/home/.luarocks/lib/lua/5.1/?.so;;";
    # ...
}
```

### 2. Making it Permanent

To avoid needing a script and allow running `lapis server` (or any LuaJIT-based tool) directly from any terminal session, add the `LD_PRELOAD` export to your `~/.bashrc`:

```bash
echo 'export LD_PRELOAD=/data/data/com.termux/files/home/openresty-install/usr/local/openresty/luajit/lib/libluajit-5.1.so.2' >> ~/.bashrc
source ~/.bashrc
```

## Verifying the Installation

Start your server using the script:

```bash
chmod +x start_server.sh
./start_server.sh
```

You can verify that everything is working by visiting `http://localhost:8080`.

Happy coding with Lapis on Termux!
