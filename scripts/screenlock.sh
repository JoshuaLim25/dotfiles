#!/bin/sh
# See https://www.reddit.com/r/swaywm/comments/p60lcb/lockscreen_and_turn_off_display/
swayidle \
    timeout 1 'swaymsg "output * dpms off"' \
    resume 'swaymsg "output * dpms on"' &
swaylock -c000000
kill %%

# and bind it to a hotkey like this in my sway config:

# bindsym XF86Sleep exec /home/jakob/.bin/lock
