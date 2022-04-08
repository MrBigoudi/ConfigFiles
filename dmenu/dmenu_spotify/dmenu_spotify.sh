#!/bin/sh
# Originally from lukesmith with some changes
# Gives a dmenu prompt to search DuckDuckGo.
# Without input, will open DuckDuckGo.com.
# Anything else, it search it.
LAUNCER="dmenu -l 5 -i -p "

tmpNames="tmpNames"

function get_playlist_name(){
    cat ${playlists} | sed -En 's/^(.*)\(spotify:playlist:.*$/\1/p' > ${tmpNames}
    }

function get_playlist_URI(){
    #$1 playlist name
    #nameRegExp="^$1[ ]*\(spotify:playlist:.*$"
    URI=$( cat ${playlists} | sed -En "/$1/s/^.*\((spotify:playlist:.*)\)$/\1/p")
    echo ${URI}
    }

playlists=~/.config/dmenu/dmenu_spotify/playlists

#creation fichier temporaire
get_playlist_name

if [ -f ${playlists} ]; then
	choice=$( (echo "Spotify" && cat ${tmpNames}) | $LAUNCER"Search:") || exit 1
else
	choice=$(echo "Spotify" | $LAUNCER -i -p ) || exit 1
fi

case "$choice" in
*Spotify*)
	spotify
	break
	;;
*)
        alacritty &
        pid=$!
        URI=$(get_playlist_URI ${choice})
        spotify --uri=${URI} &
        sleep 2
        spt play --name "$choice" --playlist --random 
        kill ${pid}
	break
	;;
esac

rm ${tmpNames}
#vim:ft=sh
