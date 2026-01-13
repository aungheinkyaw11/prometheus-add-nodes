# Prometheus Configuration

This repository contains Prometheus configuration files for monitoring
Linux and Windows servers using **file-based service discovery (file_sd)**.


---

## 🧩 Service Discovery (file_sd)

Servers are grouped by operating system:

- **Linux servers**
  - Node Exporter
  - Port: `9100`
  - File: `file_sd/linux_servers.yml`

- **Windows servers**
  - Windows Exporter
  - Port: `9182`
  - File: `file_sd/window_servers.yml`

Each target uses labels to drive alerting and identification.

### Example

```yaml
- targets: ['1.1.1.1:9182']
  labels:
    name: 'Proxy'
    os: 'windows'
