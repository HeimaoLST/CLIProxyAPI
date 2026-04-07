# CLIProxyAPI

A self-hosted proxy server providing OpenAI / Gemini / Claude compatible API endpoints, with multi-account load balancing, priority-based model group failover, and a built-in web management panel.

> For agent-assisted configuration, see [foragent.md](foragent.md) and the skill at [skills/cliproxyapi-config/SKILL.md](skills/cliproxyapi-config/SKILL.md).

---

## Deploy with Docker

### One-liner

```bash
docker run -d \
  -p 8317:8317 \
  -e MANAGEMENT_PASSWORD=your-secret \
  -v $(pwd)/config.yaml:/CLIProxyAPI/config.yaml \
  -v $(pwd)/auths:/root/.cli-proxy-api \
  --name cliproxyapi \
  ghcr.io/minervacap2022/cliproxyapi:latest
```

Pre-create the volume files before starting:

```bash
touch config.yaml && mkdir -p auths
```

### Docker Compose

```bash
# 1. Create data directories
touch config.yaml && mkdir -p auths logs

# 2. Set your management password and start
MANAGEMENT_PASSWORD=your-secret docker compose up -d
```

Then open the management panel: `http://your-server:8317/management.html`

---

## Configuration

`config.yaml` is created automatically on first management API write. You can also seed it manually:

```yaml
port: 8317

remote-management:
  allow-remote: true
  secret-key: "your-secret"   # plaintext — auto-hashed on first start

api-keys:
  - "your-client-api-key"

# Optional: model group failover
# model-groups:
#   - name: auto
#     models:
#       - { model: claude-sonnet-4-6, priority: 2 }
#       - { model: doubao-pro-32k,    priority: 1 }
#
# api-key-configs:
#   - key: "your-client-api-key"
#     model-group: auto
```

A full annotated template is at [`config.template.yaml`](config.template.yaml).

---

## Management Panel

After startup, visit `http://your-server:8317/management.html`.

From the panel you can:
- Add / manage API keys and model groups
- Upload provider auth files (Claude, Gemini, etc.)
- View request logs and usage statistics
- Edit `config.yaml` directly in the browser

---

## Image

```
ghcr.io/minervacap2022/cliproxyapi:latest   # amd64 + arm64
```

Built automatically from this repository on every push to `main`. The image bundles the latest frontend panel.

---

## License

MIT License — see [LICENSE](LICENSE) for details.

Upstream project: [router-for-me/CLIProxyAPI](https://github.com/router-for-me/CLIProxyAPI)
