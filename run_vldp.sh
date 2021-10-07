#!/bin/bash

SCRIPT_DIR=`dirname "$0"`
if realpath / >/dev/null; then SCRIPT_DIR=$(realpath "$SCRIPT_DIR"); fi
DAPHNE_BIN=daphne.bin
DAPHNE_SHARE=~/games/arcade/daphne

function STDERR () {
	/bin/cat - 1>&2
}

echo "Daphne Launcher : Script dir is $SCRIPT_DIR"
cd "$SCRIPT_DIR"

# point to our linked libs that user may not have
export LD_LIBRARY_PATH=$SCRIPT_DIR:$DAPHNE_SHARE:$LD_LIBRARY_PATH

if [ "$1" = "-fullscreen" ]; then
    FULLSCREEN="-fullscreen"
    shift
fi

if [ -z "$1" ] ; then
    echo "Specify a game to try: " | STDERR
    echo
    echo "$0 [-fullscreen] <gamename>" | STDERR


    for game in ace astron badlands bega cliff cobra esh galaxyr gpworld interstellar lair lair2 mach3 roadblaster sdq tq uvt; do
	if ls ${DAPHNE_SHARE}/vldp*/$game >/dev/null 2>&1; then
	    installed="$installed $game"
	else
	    uninstalled="$uninstalled $game"
	fi
    done
    if [ "$uninstalled" ]; then
	echo
	echo "Games not found in ${DAPHNE_SHARE}/vldp*: " | STDERR
	echo "$uninstalled" | fold -s -w60 | sed 's/^ //; s/^/\t/' | STDERR
    fi
    if [ -z "$installed" ]; then
	cat <<EOF 

Error: No games installed. DVDs can be purchased from DigitalLeisure.com.
       Please put the required files in ${DAPHNE_SHARE}/vldp_dl/gamename/
EOF
    else   
	echo
	echo "Games available: " | STDERR
	echo "$installed" | fold -s -w60 | sed 's/^ //; s/^/\t/' | STDERR
    fi
    exit 1
fi

case "$1" in
    lair|lair2|ace|tq)
	VLDP_DIR="vldp_dl"
	FASTBOOT="-fastboot"		   
	;;
    *) VLDP_DIR="vldp"
esac

#strace -o strace.txt \
./$DAPHNE_BIN $1 vldp \
$FASTBOOT \
$FULLSCREEN \
-framefile $DAPHNE_SHARE/$VLDP_DIR/$1/$1.txt \
-homedir $DAPHNE_SHARE \
-datadir $DAPHNE_SHARE \
-min_seek_delay 100 \
-seek_frames_per_ms 1000 \
-sound_buffer 2048 \
-x 1280 \
-y 720

#-bank 0 11111001 \
#-bank 1 00100111 \

EXIT_CODE=$?

if [ "$EXIT_CODE" -ne "0" ] ; then
	if [ "$EXIT_CODE" -eq "127" ]; then
		echo ""
		echo "Daphne failed to start." | STDERR
		echo "This is probably due to a library problem." | STDERR
		echo "Run ./daphne.bin directly to see which libraries are missing." | STDERR
		echo ""
	else
		echo "DaphneLoader failed with an unknown exit code : $EXIT_CODE." | STDERR
	fi
	exit $EXIT_CODE
fi

