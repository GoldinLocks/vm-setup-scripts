#!/bin/sh
echo '\nMoving to Script Directory...'
cd '/home/path/to/folder'
echo '\nStarting Script...'
echo
python3 script.py > ./data/log/"`date "+%Y-%m-%d_%H:%M:%S"`"_script_log.txt
echo 'Done!!!'