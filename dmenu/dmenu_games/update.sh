#!/bin/bash

lutris -lo | sed -En 's/^.*\|.*\|\ ([^ ]*)[ ]*\|.*\|.*$/\1/p' > ~/.config/dmenu/dmenu_games/gamesList
