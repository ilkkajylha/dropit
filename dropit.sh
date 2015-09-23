#!/bin/env bash
TMP_DIR_A=$(mktemp -d)			 # Absolute temp dir
TMP_DIR_R=$(basename "$TMP_DIR_A")	 # relative temp dir
REMOTE_DIR="/tmp/drop/"  		 # e.g /var/www/
REMOTE_HOST="127.0.0.1" 		 # fqdn or ip
REMOTE_USER="$USER"      		 # Login user at remote host 
REMOTE_URL="http://localhost:8080"	 # fqdn or ip and port, if you are using other than 80 for HTTP or 443 for HTTPS, in case you dont want to use REMOTE_HOST

scp "$1" "$REMOTE_USER"@"$REMOTE_HOST:$REMOTE_DIR""$TMP_DIR_R"
echo ""$REMOTE_URL"/"$TMP_DIR_R"/"$1""
