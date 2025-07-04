# 🔄 Automated Backup Script with Google Drive Integration

This project automates the process of backing up a GitHub repository. It creates daily, weekly, and monthly backups, uploads them to Google Drive, and sends a notification after every successful backup.

---

## 📌 What This Script Does

- 📁 Clones a GitHub repository
- 🗃️ Creates a compressed `.tar.gz` backup file
- 📂 Stores the backup in a structured folder format (`YYYY/MM/DD`)
- ☁️ Uploads the backup to Google Drive using `rclone`
- 🔁 Deletes old backups based on retention policy (daily/weekly/monthly)
- 📢 Sends a notification to a webhook (like [webhook.site](https://webhook.site))
- 📝 Logs all activities to a file

---

## 🧰 Tools & Technologies Used

- Bash Script
- Git & GitHub
- Rclone (for Google Drive)
- Cron Job (for automation)
- Webhook (for notification)
- Linux Server (Ubuntu EC2)

---

## 📂 Folder Structure

backups/
└── automated-backup/
└── 2025/
└── 07/
└── 04/
└── automated-backup_2025-07-04_10-45-12.tar.gz

makefile
Copy
Edit

---

## ⚙️ Configuration File: `.backup_config.env`

Create a config file to customize your project:

```env
PROJECT_NAME="automated-backup"
GITHUB_REPO_URL="https://github.com/shinderushi2363/automated-backup"

# Google Drive setup (configured via rclone)
DRIVE_REMOTE_NAME="google_drive"
DRIVE_FOLDER_NAME="MyBackups"

# Local backup path
BACKUP_BASE="/home/ubuntu/backups"

# Retention settings
DAILY_KEEP=7
WEEKLY_KEEP=4
MONTHLY_KEEP=3

# Webhook notification
WEBHOOK_URL="https://webhook.site/your-id"
ENABLE_NOTIFICATION=true
🚀 How to Run
1️⃣ Install rclone
bash
Copy
Edit
curl https://rclone.org/install.sh | sudo bash
rclone config
Follow prompts to link with your Google Drive.

2️⃣ Clone This Repo
bash
Copy
Edit
git clone https://github.com/shinderushi2363/automated-backup.git
cd automated-backup
3️⃣ Create .backup_config.env File
bash
Copy
Edit
nano .backup_config.env
Paste the config above and save.

4️⃣ Run the Script Manually
bash
Copy
Edit
bash ~/run_backup.sh
✅ This will:

Create a backup

Upload to Google Drive

Trigger webhook

Log the process

🕒 Automate With Cron (Optional)
To run backup every day at 2:00 AM:

bash
Copy
Edit
crontab -e
Add this line:

cron
Copy
Edit
0 2 * * * bash /home/ubuntu/run_backup.sh >> /home/ubuntu/cron_test.log 2>&1
🧪 Sample Webhook Payload
json
Copy
Edit
{
  "project": "automated-backup",
  "date": "2025-07-04",
  "test": "BackupSuccessful"
}
🛡️ Security Tip
Don’t upload .env files with secrets to public repos in real-world use.

Use fine-grained tokens for GitHub if private.

🙋 About Me
👨‍💻 Rushikesh Shinde
DevOps & Cloud Enthusiast | AWS | Bash | GitHub Automation

🔗 GitHub

🔗 LinkedIn


