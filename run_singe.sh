#!/bin/bash

SCRIPT_DIR=`dirname "$0"`
if realpath / >/dev/null; then SCRIPT_DIR=$(realpath "$SCRIPT_DIR"); fi
DAPHNE_BIN=daphne.bin
DAPHNE_SHARE=~/games/arcade/daphne

function STDERR () {
	/bin/cat - 1>&2
}

echo "Singe Launcher : Script dir is $SCRIPT_DIR"
cd "$SCRIPT_DIR"

# point to our linked libs that user may not have
export LD_LIBRARY_PATH=$SCRIPT_DIR:$DAPHNE_SHARE:$LD_LIBRARY_PATH

if [ "$1" = "-fullscreen" ]; then
    FULLSCREEN="-fullscreen"
    shift
fi

if [ -z $1 ] ; then
	echo "Specify a game to try: " | STDERR
	echo
	echo "$0 [-fullscreen] <gamename>" | STDERR
	echo

        echo -n "Games available: " | STDERR
	for game in $(ls $DAPHNE_SHARE/singe/); do
		installed="$installed $game"
	done
	echo "$installed" | fold -s -w60 | sed 's/^ //; s/^/\t/' | STDERR
	echo
	exit
fi

if [ ! -f $DAPHNE_SHARE/singe/$1/$1.singe ] || [ ! -f $DAPHNE_SHARE/singe/$1/$1.txt ]; then
        echo 
        echo "Missing file: $DAPHNE_SHARE/singe/$1/$1.singe ?" | STDERR
        echo "              $DAPHNE_SHARE/singe/$1/$1.txt ?" | STDERR
        echo 
        exit 1
fi

#strace -o strace.txt \
./$DAPHNE_BIN singe vldp \
$FULLSCREEN \
-framefile $DAPHNE_SHARE/singe/$1/$1.txt \
-script $DAPHNE_SHARE/singe/$1/$1.singe \
-homedir $DAPHNE_SHARE \
-datadir $DAPHNE_SHARE \
-sound_buffer 2048 \
-min_seek_delay 20 \
-seek_frames_per_ms 500 \
-x 1280 \
-y 720


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
