---
title: "How to Install OpenResty on Termux (Ubuntu via PRoot)"
date: 2026-03-22T10:00:00-03:00
draft: false
---

Running a full OpenResty (Nginx + Lua) stack on Android is a powerful way to develop and test web applications on the go. This guide uses `proot-distro` to set up an Ubuntu environment, providing a familiar ecosystem for OpenResty.

## Phase 1: Environment Setup in Termux

First, ensure Termux is updated and install the necessary PRoot utilities.

```bash
# Update Termux packages
pkg update && pkg upgrade

# Install PRoot and PRoot-Distro
pkg install proot proot-distro

# Install and login to Ubuntu
proot-distro install ubuntu
proot-distro login ubuntu
```

## Phase 2: Repository Configuration (Inside Ubuntu)

Once inside the Ubuntu shell, you need to add the official OpenResty package repository. This example targets **Ubuntu Noble (24.04)**.

### 1. Install Dependencies
```bash
apt-get update
apt-get -y install --no-install-recommends wget gnupg ca-certificates lsb-release
```

### 2. Import GPG Key
```bash
wget -O - https://openresty.org/package/pubkey.gpg | gpg --dearmor -o /usr/share/keyrings/openresty.gpg
```

### 3. Add OpenResty Source List
```bash
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/openresty.gpg] http://openresty.org/package/arm64/ubuntu noble main" | tee /etc/apt/sources.list.d/openresty.list > /dev/null
```

## Phase 3: Installation

Update the package lists and install OpenResty.

```bash
apt-get update
apt-get -y install openresty
```

## Phase 4: Configure for Non-Root Environment

In Termux/PRoot, you cannot bind to privileged ports below 1024 (like the default port 80). You must change the listening port to a higher value, such as **8080**.

Use `sed` to update the configuration file instantly:

```bash
# Change default port 80 to 8080
sed -i 's/listen[[:space:]]\+80;/listen 8080;/g' /usr/local/openresty/nginx/conf/nginx.conf
```

## Phase 5: Start and Verify

You can now start OpenResty using its absolute binary path. Note that `systemctl` is not available in PRoot environments.

### Start the Service
```bash
/usr/local/openresty/bin/openresty
```

### Verify it's Running
Verify that the OpenResty processes are active in the background:
```bash
ps aux | grep openresty
```

Your OpenResty server is now accessible at `http://localhost:8080`.

***

**Pro-Tip:** To stop the server, use the `-s stop` signal:
`/usr/local/openresty/bin/openresty -s stop`
