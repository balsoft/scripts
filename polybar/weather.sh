#!/usr/bin/env bash
get_icon() {
    case $1 in 
        01d) icon=🌣;;
        01n) icon=🌙;;
        02*) icon=🌤;;
        03*) icon=☁;;
        04*) icon=🌥;;
        09*) icon=🌧;;
        10*) icon=🌦;;
        11*) icon=🌩;;
        13*) icon=🌨;;
        50*) icon=🌫;;
    esac
    echo $icon
}

PREV_OUTPUT=`head -1 /proc/0/fd/0`
PREV_COLOR=`tail -1 /proc/0/fd/0`

echo -n "$PREV_OUTPUT"

export `cat ../etc/config`

weather=$(curl -sf "http://api.openweathermap.org/data/2.5/weather?APPID=$KEY&id=$CITY&units=$UNITS")
if [ ! -z "$weather" ]; then
    weather_temp=$(echo "$weather" | jq ".main.temp" | cut -d "." -f 1)
    weather_icon=$(echo "$weather" | jq -r ".weather[0].icon")
    if [ $weather_temp -lt 19 ]
    then
        color=$BLUE
    else
        if [ $weather_temp -lt 24 ]
        then
            color=$GREEN
        else
            color=$RED
        fi
    fi
    echo "%{F$PREV_COLOR}%B{$color}%{T4} %{T-}%{F$BG}%{B$color}%{T2}$(get_icon "$weather_icon")%{T-}" "$weather_temp$SYMBOL"
    echo $color
fi
