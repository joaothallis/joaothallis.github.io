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

The installation is handled by a simple script that sets up the environment and compiles OpenResty specifically for the Termux environment.

```bash
# Clone the repository
git clone https://github.com/joaothallis/termux-openresty.git
cd termux-openresty

# Run the build script
chmod +x build-openresty-termux.sh
./build-openresty-termux.sh
```

## Configuration

By default, the script installs OpenResty to `~/openresty/` and **automatically configures it to listen on port 8080**, so you can start using it immediately without root access.

If you need to make further changes to your configuration, you can find the file here:

```bash
# Check or edit the config
nano ~/openresty/nginx/conf/nginx.conf
```

## Usage

The script creates wrapper binaries in `~/bin/`. To use them, ensure this directory is in your `PATH`:

```bash
export PATH="$HOME/bin:$PATH"
```

### 1. Start the Service
```bash
openresty
```

### 2. Verify it's Running
You can verify the installation by checking the processes and testing the response:

```bash
# Check if processes are active
ps aux | grep openresty

# Test the local response
curl -I localhost:8080
```

### 3. Common Management Commands
```bash
# Test the configuration file
openresty -t

# Reload configuration without downtime
openresty -s reload

# Stop the service
openresty -s stop
```

**Note:** All native files are located within your `$HOME` directory (`~/openresty/`), completely independent of the standard Termux prefix or any PRoot environment.

Running OpenResty natively turns your Android device into a high-performance web server and Lua gateway without any extra layers. Check out the [repository](https://github.com/joaothallis/termux-openresty) for more details and to contribute!
