#!/bin/bash

screen1=''
screen2=''

function get_screen_name () {
    screen1=$(xrandr | sed -En '/\ connected\ primary.*\ /s/^(.*)\ connected\ .*$/\1/p')
    screen2=$(xrandr | sed -En '/\ connected\ [^p].*\ /s/^(.*)\ connected\ .*$/\1/p')
}

function connect_command () {
    get_screen_name
    xrandr --output ${screen1} --auto --output ${screen2} --auto --right-of ${screen1}
    sleep 2
    nitrogen --restore
}

function disconnect_command () {
    xrandr --output ${screen2} --off
}
    
function count () {
    echo $(xrandr | grep -E '\ connected\ ' | wc -l)
}

xr1=0

while true; do
    
    sleep 5

    # second count
    xr2=$(count)
    
    # check if there is a change in the screen state
    if [ ${xr2} != ${xr1} ]; then 
        
        if [ ${xr2} == 2 ]; then
            # command to run if connected (two screens)
            connect_command
        
        else  
            # command to run if disconnected (one screen)
            disconnect_command
        fi

    xr1=${xr2}

    fi

done
