#!/bin/bash

# Load variables from your .env file
source ~/.backup_config.env

# Time and paths
NOW=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_DIR="$BACKUP_BASE/$PROJECT_NAME"
ARCHIVE_NAME="${PROJECT_NAME}_$NOW.tar.gz"
ARCHIVE_PATH="$BACKUP_DIR/$ARCHIVE_NAME"

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Create a temp directory
TEMP_DIR="/tmp/$PROJECT_NAME"
rm -rf "$TEMP_DIR"
mkdir -p "$TEMP_DIR"

# Try to clone GitHub repo
if [[ "$GITHUB_REPO_URL" != "" && "$GITHUB_REPO_URL" != "https://github.com/YOUR_USERNAME/YOUR_REPO.git" ]]; then
    echo "🔄 Cloning from GitHub repo..."
    git clone "$GITHUB_REPO_URL" "$TEMP_DIR" || echo "⚠️ Git clone failed or repo is empty. Creating dummy file instead."
fi

# If the repo is empty, fallback to dummy file
if [ ! "$(ls -A $TEMP_DIR)" ]; then
    echo "📄 This is a test backup file." > "$TEMP_DIR/readme.txt"
fi

# Create a compressed backup archive
tar -czf "$ARCHIVE_PATH" -C "$TEMP_DIR" .

# Upload to Google Drive using rclone
echo "☁️ Uploading to Google Drive..."
rclone copy "$ARCHIVE_PATH" "$DRIVE_REMOTE_NAME:$DRIVE_FOLDER_NAME"

# Clean temp folder
rm -rf "$TEMP_DIR"

# Delete old backups based on retention
find "$BACKUP_DIR" -name "*.tar.gz" -type f -mtime +$DAILY_KEEP -exec rm {} \;

# Send notification if enabled
if [ "$ENABLE_NOTIFICATION" = true ]; then
  curl -X POST -H "Content-Type: application/json" \
  -d "{\"text\": \"✅ Backup for $PROJECT_NAME completed at $NOW\"}" \
  "$WEBHOOK_URL"
fi

