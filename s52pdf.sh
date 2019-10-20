#!/bin/bash

if test $# -ne 1
then
    echo "usage: $0 <html-file-name>"
    exit 1
fi

name=${1%.html}

n=$(grep -c '"slide"' $name.html)

export GOOGLE_API_KEY=0 GOOGLE_DEFAULT_CLIENT_ID=0 GOOGLE_DEFAULT_CLIENT_SECRET=0
export DISPLAY=:17
Xvfb $DISPLAY -screen 0 1920x1080x24+32 >/dev/null 2>&1 &
metacity 2>/dev/null &
firefox -no-remote -P other -safe-mode $name.html 2>/dev/null &

i=-6
while test $i -lt 0
do
    echo -ne "$i\r"
    sleep 1
    ((i++))
    case $i in
        -3) xsetroot -solid green
            wmctrl -ar firefox
            xdotool key Return
            ;;
        -2) xdotool key F11
            xdotool mousemove 30 30
            ;;
    esac
done
echo -ne "  \r"

rm -f capture??.png
while test $i -lt $n
do
    echo -ne "$i\r"
    sleep 0.25
    scrot $(printf "capture%02d.png" $i)
    xdotool click 1
    ((i++))
done
echo -ne ".  \r"

xdotool key ctrl+w
xdotool key ctrl+w

convert capture??.png $name.pdf
rm -f capture??.png

kill %2 %1
