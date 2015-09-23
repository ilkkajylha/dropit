#!/bin/env bash
LOCAL_FILE=""				 # Can also be folder...confusing aint it?
TMP_DIR_A=$(mktemp -d)			 # Absolute temp dir
TMP_DIR_R=$(basename "$TMP_DIR_A")	 # relative temp dir
REMOTE_DIR="/tmp/drop/"  		 # e.g /var/www/
REMOTE_HOST="127.0.0.1" 		 # fqdn or ip
REMOTE_USER="$USER"      		 # Login user at remote host 
REMOTE_URL="http://localhost:8080"	 # fqdn or ip and port, if you are using other than 80 for HTTP or 443 for HTTPS, in case you dont want to use REMOTE_HOST
function upload_screenshot {
	if [[ "$1" -eq "-s" ]]; then
		SCREENSHOT_PATH="$(scrot -s '/tmp/%Y-%m-%d-%s.png' -e 'echo $f')"
		SCREENSHOT_FILE=$(basename "$SCREENSHOT_PATH")
		rsync -e ssh -r "$SCREENSHOT_PATH" "$REMOTE_USER"@"$REMOTE_HOST:$REMOTE_DIR""$TMP_DIR_R"/ #/"$SCREENSHOT_FILE"	
		echo  ""$REMOTE_URL"/"$TMP_DIR_R"/"$SCREENSHOT_FILE"" 
fi
}

function upload_file_or_dir {
	if [[ -d "$1" ]]; then
		rsync -e ssh -r  "$1" "$REMOTE_USER"@"$REMOTE_HOST:$REMOTE_DIR""$TMP_DIR_R"/
	else
		rsync -e ssh  "$1" "$REMOTE_USER"@"$REMOTE_HOST:$REMOTE_DIR""$TMP_DIR_R"
	fi
	echo ""$REMOTE_URL"/"$TMP_DIR_R"/"$1""
}
if [[ "$1" -eq "-s" ]]; then
	upload_screenshot
else
	upload_file_or_dir
fi
