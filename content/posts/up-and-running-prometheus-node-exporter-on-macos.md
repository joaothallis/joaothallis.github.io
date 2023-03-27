---
title: "Up and Running Prometheus node_exporter on macOS"
date: 2023-03-27
draft: false
---

1. Install `node_exporter`

```bash
brew install node_exporter
```

2. Start `node_exporter`

```bash
brew services start node_exporter
```

3. Now you can see the logs at [localhost:9100/metrics](http://localhost:9100/metrics)

```bash
open -n -a Safari localhost:9100/metrics
```
