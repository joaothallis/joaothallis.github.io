---
title: "Serving Web Server Using Tailscale"
date: 2023-05-23T23:43:52-03:00
draft: false
---

It will be served inside the [tailnet](https://tailscale.com/kb/1155/terminology-and-concepts/#tailnet), as example I am using this [blog](https://github.com/joaothallis/joaothallis.github.io).

For it, you will need to install [hugo](https://gohugo.io/getting-started/installing/) and [tailscale](https://tailscale.com/download).

To serve:

```bash
git clone git@github.com:joaothallis/joaothallis.github.io.git
cd joaothallis.github.io
hugo serve &
sudo tailscale serve tcp:1313 tcp://127.0.0.1:1313
# to get the URL
tailscale serve status | head -1 | grep -oP "(?<=tcp://)[^ ]+"
```

Now with the URL you can access it in any device inside the tailnet.

To stop serving:

```bash
sudo tailscale serve tcp:1313 tcp://127.0.0.1:1313 off
kill hugo
```
