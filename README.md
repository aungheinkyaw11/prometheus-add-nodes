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
- targets: ['18.141.220.43:9182']
  labels:
    name: 'Channel Proxy'
    os: 'windows'
```

### Automation Script
Add a new server automatically

#### Script:
```
run.sh
```


#### Features:

Choose OS (Linux / Windows)

Auto-select correct port

Adds required labels

Creates timestamped backups before changes

#### Usage

```
chmod +x scripts/add_node.sh
./scripts/add_node.sh
```

#### Backups

Before modifying any file_sd file, the script creates a backup:

```
backup/
├── linux_servers.yml.YYYYMMDD_HHMMSS.bak
├── window_servers.yml.YYYYMMDD_HHMMSS.bak
```

#### Reload Prometheus

After changes:

```
curl -X POST http://localhost:9090/-/reload
```

Or rely on Prometheus automatic reload for file_sd.

#### Validation

Always validate configs before reload:

```
promtool check config prometheus.yml
promtool check rules rules/server-alerts.yml
```