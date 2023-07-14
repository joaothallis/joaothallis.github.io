---
title: "How to Run mssql Docker Image on Apple Silicon"
date: 2023-07-14T00:05:08-03:00
draft: false
---

I was having this [issue](https://github.com/microsoft/mssql-docker/issues/668) when I was running the container.

## Solution if you are using `colima` to run Docker containers

```bash
colima start --arch aarch64 --vm-type=vz --vz-rosetta
```

Thanks [Felix Rabe](https://github.com/frab3) for the [answer](https://github.com/microsoft/mssql-docker/issues/668#issuecomment-1477512288).
