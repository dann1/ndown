#!/bin/bash

config=examples/download.conf

source $config

for i in $root_dir $input_dir $download_dir $web_dir; do
	mkdir -p $i
done

touch $logfile
cp -r $config $root_dir
cp -r src/* $root_dir
chmod +x $root_dir/{common,download,killer}.sh
