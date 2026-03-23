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

By default, the script installs OpenResty into a custom directory in your home folder. Because paths can vary depending on your specific environment, the most reliable way to find your configuration file is to check the `openresty` wrapper script itself:

```bash
# Find the prefix used by the wrapper
cat $(which openresty) | grep "exec"
```

In your current environment, the configuration file is located at:
`~/openresty-install/usr/local/openresty/nginx/conf/nginx.conf`

To check your configuration file:
```bash
# Replace with the path found above if different
ls -F ~/openresty-install/usr/local/openresty/nginx/conf/nginx.conf
```

**Note:** The build script automatically configures the server to listen on port **8080**, so you can start it immediately without manual configuration changes.

## Usage

The script creates wrapper binaries in `~/bin/`. Ensure this directory is in your `PATH`:

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
The wrapper supports standard Nginx signals:

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
