#!/bin/bash

source $(dirname $0)/download.conf
source $(dirname $0)/common.sh

function downloader {
	tarea=$1
	case $tarea in
		youtube )
			comando="youtube-dl -r $bandwidth -c -o '%(title)s.%(ext)s' --restrict-filenames"
			;;
		webs )
			comando="wget --limit-rate=$bandwidth -P $web_dir -U $user_agent -e robots=off --recursive --no-parent --page-requisites --convert-links"
			;;		
		aria2 )
			comando="aria2c -c --max-download-limit=$bandwidth --max-connection-per-server=$conperserv  --file-allocation=falloc --optimize-concurrent-downloads=true --disk-cache=$cache --async-dns=false"
			;;
	esac

	lista=$(grep -v '^#' < $input_dir/$tarea.links) # avoid lines starting with hashtag
	for i in $lista; do		
		logger "Downloading $i" $logfile && eval $comando  $i  && logger "Finished downloading $i"
	done	 
}

cd $download_dir

logger "BEGIN" $logfile

downloader youtube &
downloader aria2 &
downloader webs &

logger "FINISH" $logfile