#!/bin/sh
TASK=$1
if [[ "$TASK" == "" ]]; then
    TASK="build"
fi
./targets/${TASK} ${*:2}