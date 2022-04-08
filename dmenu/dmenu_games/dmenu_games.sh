#!/bin/sh
# Originally from lukesmith with some changes
# Gives a dmenu prompt to search DuckDuckGo.
# Without input, will open DuckDuckGo.com.
# Anything else, it search it.
LAUNCER="dmenu -l 5 -i -p "
if [ -f ~/.config/dmenu/dmenu_games/gamesList ]; then
	choice=$( (echo "Steam" && echo "Lutris" && cat ~/.config/dmenu/dmenu_games/gamesList) | $LAUNCER"Search:") || exit 1
else
	choice=$(echo "Steam" | $LAUNCER -i -p ) || exit 1
fi

case "$choice" in
*Steam*)
	STEAM_RUNTIME_HEAVY=1 prime-run steam
	exit
	;;
*Lutris*)
        lutris
        exit
        ;;
*) 
        lutris lutris:rungame/$choice
	exit
	;;
esac
#vim:ft=sh
