
# shebang/sha-bang/hashbang first line of the script file telling the OS which interpreter to use
#!/bin/bash

# variable date storing time stamp
DATE=$(date +"%Y-%m-%d_%H-%M-%S")

# source is the folder that will be backed up
# $HOME expands home directory
# $BACKUP_DIR is where the backups will be kept
# $LOG_FILE stores the path to the log file

SOURCE="$HOME/automation-project/testdata"
BACKUP_DIR="$HOME/automation-project/backups"
LOG_FILE="$HOME/automation-project/logs/backup.log"

# -p if parent folder doesn't already exist, create it 

# makes the directory
mkdir -p $BACKUP_DIR

# grabs only the path to the folder
mkdir -p $(dirname $LOG_FILE)

# writes message to log file
echo "[$DATE] Starting backup..." >> $LOG_FILE

# -a archive mode: preserves permissions, timestamps and folder structure
# -v verbose mode: shows detailed output
# --delete deletes files in backup that were deleted from source
# 2>&1 sends errors to same place as the normal output
# backup command, used for backups, syncing servers and copying files
rsync -av --delete $SOURCE $BACKUP_DIR >> $LOG_FILE 2>&1

# -czf creates archive, gzip compression, filename
# -C change directory before compressing 
# compresses the backup
tar -czf "$BACKUP_DIR/backup_$DATE.tar.gz" -C $BACKUP_DIR testdata >> $LOG_FILE 2>&1

# message to confirm successful backup
echo "[$DATE] Backup Completed">> $LOG_FILE
