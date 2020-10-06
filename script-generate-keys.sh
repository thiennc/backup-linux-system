#!/bin/sh
PROJECT_NAME="sample-project"
KEYS_PATH="/home/backup/keys"
KEY_TIMESTAMP=$(date +"%Y%m%d%H%M%S")
mkdir -p $KEYS_PATH
openssl req -newkey rsa:2048 -new -nodes -x509 -days 36500 -keyout $KEYS_PATH/$PROJECT_NAME"-private-key-"$KEY_TIMESTAMP.pem -out $KEYS_PATH/$PROJECT_NAME"-backup-key-"$KEY_TIMESTAMP.pem -subj "/C=VN/ST=Vietnam/L=Vietnam/O=Global Security/OU=IT Department/CN=$PROJECT_NAME"
chmod 400 $KEYS_PATH/$PROJECT_NAME"-private-key-"$KEY_TIMESTAMP.pem
chmod 400 $KEYS_PATH/$PROJECT_NAME"-backup-key-"$KEY_TIMESTAMP.pem
