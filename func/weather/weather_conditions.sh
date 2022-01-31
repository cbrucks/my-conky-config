#!/bin/bash
# San Antonio - KSKF

# Possible Weather Conditions
# - NA
# - Fair
# - A Few Clouds
# - Partly Cloudy
# - Mostly Cloudy
# - Overcast
# - Light Drizzle
# - Drizzle
# - Light Rain
# - Rain
# - Heavy Rain
# - Thunderstorm
# - Thunderstorm in Vicinity
# - Breezy
# - Fog/Mist
# - Mist

if [ $1 ]; then
    format=$1
fi

AREA="KT82"
WEATHER_URL="http://weather.noaa.gov/pub/data/observations/metar/decoded/$AREA.TXT"

function get_sky_cond () {
    echo $(curl -s $WEATHER_URL | grep -oP "(?<=Sky conditions: ).*")
}

function get_sky_cond_num() {
    data=$(echo $1 | awk '{print tolower($0)}')
    case "$data" in
        "na")                       echo -1 ;;
        "clear")                    echo 0  ;;
        "mostly clear")             echo 1  ;;
        "partly cloudy")            echo 2  ;;
        "mostly cloudy")            echo 3  ;;
        "overcast")                 echo 4  ;;
    esac
}

sky_cond=$(get_sky_cond)
case $format in
    display)
        echo $sky_cond;;
    num)
        echo $(get_sky_cond_num "$sky_cond");;
    *)
        echo $sky_cond;;
esac
