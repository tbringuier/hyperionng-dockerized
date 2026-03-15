# Hyperion NG — Dockerized

Lightweight, multi-architecture Docker image for [Hyperion NG](https://github.com/hyperion-project/hyperion.ng) — open-source ambient lighting software.

## Features

- **Multi-architecture** — `amd64`, `arm64`, `arm/v7` (Raspberry Pi)
- **Minimal footprint** — Debian slim base, build deps purged after install
- **Auto-updated** — GitHub Actions checks daily for new stable Hyperion releases and rebuilds the image automatically
- **GHCR** — Published to GitHub Container Registry

## Quick Start

```bash
docker run -d \
  --name hyperion \
  --network host \
  -e TZ=Europe/Paris \
  -v hyperion_config:/config \
  ghcr.io/tbringuier/hyperionng-dockerized:latest
```

Or with Docker Compose:

```bash
docker compose up -d
```

## Configuration

### Environment Variables

| Variable | Default | Description |
|---|---|---|
| `TZ` | `UTC` | Container timezone |
| `HYPERION_USERDATA_DIR` | `/config` | Path to Hyperion userdata inside the container |

### Ports

| Port | Description |
|---|---|
| `8090` | Web UI / JSON API |
| `8092` | JSON API (WebSocket) |
| `19444` | Protobuf |
| `19445` | Flatbuffers |

> When using `network_mode: host` (recommended), no port mapping is needed.

### Volumes

| Path | Description |
|---|---|
| `/config` | Persistent Hyperion configuration |

### USB Capture Device

To pass through a V4L2 video capture device:

```yaml
devices:
  - /dev/video0:/dev/video0
```

## Building Locally

```bash
docker build -t hyperionng .
```
