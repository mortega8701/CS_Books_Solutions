#!/bin/bash

filename="countFile"

if [ ! -f "$filename" ]; then
    touch $filename
else
    : > $filename
fi

badLockFunction() {
    local thread_id=$BASHPID
    local count=0
    while [ $count -lt 10000 ]; do
        readcount=$(tail -n 1 "$filename")
        if [ -z "$readcount" ]; then
            count=0
        fi
        count=$((count +1))
        echo "$count" >> $filename
        echo "$count done by $thread_id"
    done
}

goodLockFunction() {
    local thread_id=$BASHPID
    local count=0
    exec 9>>"$filename"
    while [ $count -lt 10000 ]; do
        flock -x 9
        readcount=$(tail -n 1 "$filename")
        if [ -z "$readcount" ]; then
            count=0
        fi
        count=$((count +1))
        echo "$count" >&9
        flock -u 9
        echo "$count done by $thread_id"
    done
    exec 9>&-
}

badLockFunction &
badLockFunction &
#goodLockFunction &
#goodLockFunction &

wait
