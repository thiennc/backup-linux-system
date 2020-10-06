#!/bin/sh
PROJECT_NAME="project1"
PUBLIC_IP="123.123.123.123"
BACKUP_PATH="/home/backup/"
BACKUP_FOLDER="backup-system-"$PROJECT_NAME"-"$PUBLIC_IP"-$(date +"%Y%m%d")"

mkdir -p $BACKUP_PATH
cd $BACKUP_PATH
mkdir -p $BACKUP_FOLDER/etc
cp -r /etc/nginx $BACKUP_FOLDER/etc
cp -r /etc/apache2 $BACKUP_FOLDER/etc
cp -r /etc/default $BACKUP_FOLDER/etc
cp -r /etc/letsencrypt $BACKUP_FOLDER/etc
cp /etc/iptables.save $BACKUP_FOLDER/etc
cp /etc/hosts $BACKUP_FOLDER/etc
cp /etc/passwd $BACKUP_FOLDER/etc
cp /etc/rc.local $BACKUP_FOLDER/etc

mkdir -p $BACKUP_FOLDER/var/spool
cp -r /var/spool/cron $BACKUP_FOLDER/var/spool

tar -czvf $BACKUP_FOLDER.tar.gz $BACKUP_FOLDER
rm -rf $BACKUP_FOLDER

openssl smime -encrypt -binary -aes-256-cbc -in $BACKUP_FOLDER.tar.gz -out $BACKUP_FOLDER.tar.gz.enc -outform DER keys/key-backup-$PROJECT_NAME.pem
rm $BACKUP_FOLDER.tar.gz
