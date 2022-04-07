#!/bin/sh
# Originally from lukesmith with some changes
# Gives a dmenu prompt to search DuckDuckGo.
# Without input, will open DuckDuckGo.com.
# Anything else, it search it.
LAUNCER="dmenu -l 5 -i -p "
#[ -z "${DISPLAY}" ] && LAUNCER="fzf --prompt "
localBROWSER="qutebrowser "
#[ -n "$*" ] && localBROWSER="$*"
#[ -z "${DISPLAY}" ] && localBROWSER="w3m "
if [ -f ~/.config/qutebrowser/bookmarks/urls ]; then
	choice=$( (echo "qb" && cat ~/.config/qutebrowser/bookmarks/urls) | $LAUNCER"Search:") || exit 1
else
	choice=$(echo "qb" | $LAUNCER -i -p "Search DuckDuckGo:") || exit 1
fi
case "$choice" in
*qb*)
	$localBROWSER"https://duckduckgo.com" &
	exit
	;;
http*)
	$localBROWSER"$(echo $choice | awk '{print $1}')" &
	exit
	;;
*) $localBROWSER"https://duckduckgo.com/?q=$choice" &
	exit
	;;
esac
#vim:ft=sh
