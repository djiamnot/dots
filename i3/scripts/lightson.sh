#!/bin/bash

while true
do
    activ_win_id=`xprop -root _NET_ACTIVE_WINDOW`
    xprop -id ${activ_win_id:40:9} | grep _NET_WM_STATE_FULLSCREEN && xset -dpms; xset +dpms
    sleep 120
done
