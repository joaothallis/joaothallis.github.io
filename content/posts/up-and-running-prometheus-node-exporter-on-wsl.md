---
title: "Up and Running Prometheus node_exporter on WSL"
date: 2022-12-16
draft: false
---

1. Install `node_exporter`

```bash
sudo apt install prometheus-node-exporter
```

2. Start `node_exporter`

```bash
sudo service prometheus-node-exporter start
```

3. Now you can see the logs at [localhost:9100/metrics](http://localhost:9100/metrics)

```bash
export DISPLAY=:0
export BROWSER=/usr/bin/wslview
open localhost:9100/metrics
```
