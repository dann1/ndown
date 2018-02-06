#!/bin/bash

for i in aria2c rsync youtube-dl wget; do
	killall -g $i
done