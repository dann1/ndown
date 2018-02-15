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
			comando="wget --limit-rate=amount=$bandwidth -P Websites -U chrome -e robots=off --continue -r -k --no-parent --page-requisites --convert-links --no-clobber --domain="
			;;		
		aria2 )
			comando="aria2c -c --max-download-limit=$bandwidth --max-connection-per-server=16  --file-allocation=falloc --optimize-concurrent-downloads=true --disk-cache=1024M --async-dns=false"
			;;
	esac

	lista=$(cat $input_dir/$tarea.links)

	for i in $lista; do
		if [[ ${i:0:1} == "#" ]]; then # avoid lines starting with hashtag
			:
		else
			logger "Downloading $i" $logfile
			eval $comando  $i &
		fi	
	done	 
}

cd $download_dir

logger "BEGIN" $logfile

downloader youtube
downloader aria2
downloader webs

logger "FINISH" $logfile