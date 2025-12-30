#!/bin/sh
# ~/.config/dunst/launchdunst.sh
# Script to launch/reload dunst with pywal colors

# Load pywal colors
[ -f "$HOME/.cache/wal/colors.sh" ] && . "$HOME/.cache/wal/colors.sh"

# Kill existing dunst process
pidof dunst && killall dunst

# Launch dunst with pywal colors
# Using a sensible color mapping:
# - Low urgency: dark background, light foreground
# - Normal urgency: dark background, bright foreground  
# - Critical urgency: accent background, bright foreground
dunst -lf  "${color7:-#ffffff}" \
      -lb  "${color0:-#000000}" \
      -lfr "${color1:-#ff0000}" \
      -nf  "${color15:-#ffffff}" \
      -nb  "${color0:-#000000}" \
      -nfr "${color1:-#ff0000}" \
      -cf  "${color0:-#ffffff}" \
      -cb  "${color1:-#ff0000}" \
      -cfr "${color9:-#ff0000}" > /dev/null 2>&1 &
