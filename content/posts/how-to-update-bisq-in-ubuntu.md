+++
title = "How to Update Bisq in Ubuntu"
date = 2021-01-03
+++

Close Bisq and make a [backup](https://bisq.wiki/Backing_up_application_data).

## Download Bisq

Download the new version of Bisq in 
[GitHub releases](github.com/bisq-network/bisq/releases), at the time I write
this tutorial, the latest version is 1.5.4, replace 1.5.4 with the current
latest version.

```bash
wget https://github.com/bisq-network/bisq/releases/download/v1.5.4/Bisq-64bit-1.5.4.deb
```

## Verify

Import the key to verify:

```bash
curl https://bisq.network/pubkey/29CDFD3B.asc | gpg --import
```

Download Bisq-64bit-1.5.4.deb.asc:

```bash
wget https://github.com/bisq-network/bisq/releases/download/v1.5.4/Bisq-64bit-1.5.4.deb.asc
```

Verify:

```bash
gpg --digest-algo SHA256 --verify Bisq-64bit-1.5.4.deb{.asc*,}
```

## Install

```bash
sudo dpkg -i Bisq-64bit-1.5.3.deb
```

The output will be something like this:

```bash
(Reading database ... 224728 files and directories currently installed.)
Preparing to unpack .../Downloads/Bisq-64bit-1.5.4.deb ...
Removing shortcut
Unpacking bisq (1.5.4) over (1.5.3) ...
Setting up bisq (1.5.4) ...
Adding shortcut to the menu
```

## Verify jar file after installation

```bash
hash=$(shasum -a256 /opt/Bisq/app/desktop-1.5.4-all.jar)

expected_hash=$(wget -qO- https://github.com/bisq-network/bisq/releases/download/v1.5.4/Bisq-1.5.4.jar.txt)

if [ "$hash" = "$expected_hash" ]; then
    echo "Hashs are equal."
else
    echo "Hashs are not equal."
fi
```

Open Bisq to test the new version:

```bash
/opt/Bisq/Bisq
```
