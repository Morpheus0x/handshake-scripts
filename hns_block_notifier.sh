#!/bin/bash

# requirements: curl, jq, notify-send, date

# hsd server setup
# on the server open port 12037 (user ufw for easy firewall setup)
# user 'openssl rand -hex 32' to create a strong api key
# user screen or byobu to see what the output of hsd is, otherwise use the --daemon option
# example command: ./hsd --http-host 'yourdomain.com' --api-key 'your_key'

API_KEY="very_secure"
SERVER="http://localhost:12037/"	#if hsd is hosted on a server, replace localhost with ip or domain

LAST_BLOCK="1"
LAST_DATE="$(date +%s)"
#unix timestamp with nanoseconds: $(date +%s.%N) $(date -d@68.5 -u +%H:%M:%S.%N) $(expr 500000000 / 1000000)

while true; do
	CURRENT_BLOCK=$(curl -su x:"${API_KEY}" "${SERVER}" | jq -r ".chain.height")
	CURRENT_DATE=$(date +%s)
	if [[ ${CURRENT_BLOCK} > ${LAST_BLOCK} ]]; then
		#the first two messages have very likely incorrect block mine time
		DURATION="$(date -d@$(expr ${CURRENT_DATE} - ${LAST_DATE}) -u +%H:%M:%S)"
		MESSAGE_STRING="New Block Mined! Current Hight: ${CURRENT_BLOCK}, This block took ${DURATION} to mine."
		notify-send "${MESSAGE_STRING}" --icon=dialog-information
		echo "[$(date +%c)] ${MESSAGE_STRING}"
		# todo: log file
		LAST_BLOCK="${CURRENT_BLOCK}"
		LAST_DATE="${CURRENT_DATE}"
	fi
	sleep 1		#can be set lower to dos your server if you want
done

