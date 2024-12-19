#!/bin/bash

if pgrep -x "conky" > /dev/null
then
    killall conky
else
    conky -c ~/.config/conky/conky.conf &
fi
