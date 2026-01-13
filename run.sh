#!/bin/bash

BASE_DIR="/etc/prometheus"
BACKUP_DIR="$BASE_DIR/backup"
DATE=$(date +"%Y%m%d_%H%M%S")

mkdir -p "$BACKUP_DIR"

echo "Select OS type:"
select OS in "linux" "windows"; do
  case $OS in
    linux )
      FILE="$BASE_DIR/file_sd/linux_servers.yml"
      PORT="9100"
      OS_LABEL="linux"
      break;;
    windows )
      FILE="$BASE_DIR/file_sd/window_servers.yml"
      PORT="9182"
      OS_LABEL="windows"
      break;;
    * )
      echo "Invalid option"
      ;;
  esac
done

# Backup before modifying
BACKUP_FILE="$BACKUP_DIR/$(basename "$FILE").$DATE.bak"
cp "$FILE" "$BACKUP_FILE"

echo "Backup created: $BACKUP_FILE"

read -p "Enter server name: " NAME
read -p "Enter server IP: " IP

cat <<EOF >> "$FILE"

    - targets: ['$IP:$PORT']
      labels:
        name: '$NAME'
        os: '$OS_LABEL'
EOF

echo "✅ Server added successfully!"
echo "📄 File updated: $FILE"
