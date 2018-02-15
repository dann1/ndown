#!/bin/bash

for i in aria2c youtube-dl wget; do
	killall -g $i
done