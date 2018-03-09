#!/bin/bash

source $(dirname $0)/config/download.conf
source $(dirname $0)/common.sh

function downloader {
	tarea=$1
	case $tarea in
		youtube )
			comando="youtube-dl -r $bandwidth -c -o '%(title)s.%(ext)s' --restrict-filenames"
			;;
		webs )
			bw=$(echo "$bandwidth" | tr '[:upper:]' '[:lower:]')
			comando="wget -P  $web_dir --limit-rate=$bw -U $user_agent -e robots=off --continue -r -k --no-parent --page-requisites --convert-links --no-clobber --domain="
			;;		
		aria2 )
			comando="aria2c -c --max-download-limit=$bandwidth --max-connection-per-server=$conperserv  --file-allocation=falloc --optimize-concurrent-downloads=true --disk-cache=$cache --async-dns=false"
			;;
	esac

	lista=$(grep -v '^#' < $input_dir/$tarea.links) # avoid lines starting with hashtag
	for i in $lista; do
		logger "Downloading $i" $logfile
		eval $comando  $i &
	done	 
}

cd $download_dir

logger "BEGIN" $logfile

downloader youtube
downloader aria2
downloader webs

logger "FINISH" $logfile