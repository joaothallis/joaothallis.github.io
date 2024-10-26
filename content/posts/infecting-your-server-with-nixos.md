---
title: "Infecting Your Server With Nixos"
date: 2024-10-26T11:14:05+02:00
draft: false
---

To infect your server with NixOS you need to run a non NixOS Linux distribution. 
It works on some Linux distributions, you can check the list of supported 
distributions [here](https://github.com/elitak/nixos-infect/). You can use a
virtual machine or a dedicated machine (locally or using a cloud provider).

## Step 1: Create SSH Keys

First, you need to create SSH keys to access your server. To infect your machine
you need to have root access using SSH Keys, it's not possible to infect a
machine without SSH access because [nixos-infect](https://github.com/elitak/nixos-infect/) is not able to get your current
password and set on the new operating system (NixOS).

```bash
ssh-keygen
```

You need to copy your public key to the server. You can do this by running the following command:

```bash
ssh-copy-id root@your-server-ip
```

If you are using a cloud provider, you can use the web interface to add your SSH key.

To copy your public key to the server, you can also use the following command:

```bash
cat ~/.ssh/id_ed25519.pub | xclip # or pbcopy on macOS
```

Verify that you can access your server using SSH:

```bash
ssh root@your-server-ip
```

If you have more than one SSH key, you can specify the key to use with the `-i` flag:

```bash
ssh -i ~/.ssh/id_ed25519 root@your-server-ip
```

## Step 2: Infect Your Server

Now that you have access to your server, you can infect it with NixOS. If you 
are using a Virtual Machine or a dedicated machine, you can use the following
command:

```bash
curl https://raw.githubusercontent.com/elitak/nixos-infect/master/nixos-infect | NIX_CHANNEL=nixos-23.05 bash -x
```

If you are using a cloud provider, you can use cloud-init/user data mechanism 
interface to provide the script to infect your server. For example, on 
DigitalOcean, you can use the following script:

```bash 
#cloud-config

runcmd:
  - curl https://raw.githubusercontent.com/elitak/nixos-infect/master/nixos-infect | PROVIDER=digitalocean NIX_CHANNEL=nixos-23.05 bash 2>&1 | tee /tmp/infect.log
```

You can check what command to use on your cloud provider 
[here](https://github.com/elitak/nixos-infect/#hoster-notes).

After a few minutes, your server will be infected with NixOS. 
You can access and verify that it worked:

```
nix-shell -p freshfetch --command freshfetch
            ::::.    ':::::     ::::'          root@nixos
            ':::::    ':::::.  ::::'
              :::::     '::::.:::::            OS: NixOS 23.05 (Stoat) x86_64
        .......:::::..... ::::::::             Host: Droplet
       ::::::::::::::::::. ::::::    ::::.     Kernel: Linux 6.1.69
      ::::::::::::::::::::: :::::.  .::::'     Uptime: 36 minutes
             .....           ::::' :::::'      Packages: 0
            :::::            '::' :::::'       Shell: bash
   ........:::::               ' :::::::::::.  Resolution: 1024x768
  :::::::::::::                 :::::::::::::  CPU: DO-Regular (1) @ 1.9953100681305MHz
   ::::::::::: ..              :::::           Board: DigitalOcean Droplet
       .::::: .:::            :::::            Memory: 68MB / 473MB
      .:::::  :::::          '''''    .....
      :::::   ':::::.  ......:::::::::::::'
       :::     ::::::. ':::::::::::::::::'
              .:::::::: '::::::::::
             .::::''::::.     '::::.
            .::::'   ::::.     '::::.
           .::::      ::::      '::::.
```

Congratulations! You have successfully infected your server with NixOS.
