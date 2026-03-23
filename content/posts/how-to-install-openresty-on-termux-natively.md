---
title: "How to Install OpenResty on Termux (Natively)"
date: 2026-03-22T11:00:00-03:00
draft: false
---

In my [previous post](/posts/how-to-install-openresty-on-termux-with-proot/), I showed how to run OpenResty using a PRoot Ubuntu environment. While that method is reliable, it comes with the overhead of a containerized distribution.

If you want maximum performance and a smaller footprint, you can now run OpenResty natively on Termux. I created the [termux-openresty](https://github.com/joaothallis/termux-openresty) project to make this process seamless.

## Why Native?

- **Performance:** No PRoot emulation overhead.
- **Simplicity:** Stay within the Termux environment without switching to a different distribution shell.
- **Storage:** Saves space by not requiring a full Ubuntu rootfs.

## Installation

The installation is handled by a simple script that sets up the environment and compiles the necessary components for Android's architecture.

```bash
# Clone the repository
git clone https://github.com/joaothallis/termux-openresty.git
cd termux-openresty

# Run the build script
chmod +x build-openresty-termux.sh
./build-openresty-termux.sh
```

## Configuration

Just like the PRoot version, native OpenResty cannot bind to port 80 without root. The installer defaults to a safe port, but you can always verify or change it in your `nginx.conf`.

The native installation typically resides in your home directory (`~/openresty/`). You can use `sed` to update the configuration file:

```bash
# Change default port 80 to 8080
sed -i 's/listen[[:space:]]\+80;/listen 8080;/g' ~/openresty/conf/nginx.conf
```

**Note:** If the command above fails with a "No such file or directory" error, verify your exact configuration path by running:
```bash
openresty -V 2>&1 | grep -oP "(?<=--conf-path=)[^ ]+"
```

## Usage

Once installed, you can manage OpenResty directly from your Termux command line. The installer creates wrapper binaries in `~/bin/`.

### Start the Service
```bash
openresty
```

### Verify it's Running
Verify that the processes are active in the background:
```bash
ps aux | grep openresty
```

**Note:** Unlike the PRoot method, do not use `/usr/local/` paths. All native files are located within your `$HOME` directory.

Running OpenResty natively turns your Android device into a high-performance web server and Lua gateway without any extra layers. Check out the [repository](https://github.com/joaothallis/termux-openresty) for more details and to contribute!
