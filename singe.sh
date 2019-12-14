#!/bin/sh

SCRIPT_DIR=`dirname "$0"`
if realpath / >/dev/null; then SCRIPT_DIR=$(realpath "$SCRIPT_DIR"); fi
DAPHNE_BIN=daphne.bin
DAPHNE_SHARE=~/.daphne

echo "Singe Launcher : Script dir is $SCRIPT_DIR"
cd "$SCRIPT_DIR"

# point to our linked libs that user may not have
export LD_LIBRARY_PATH=$SCRIPT_DIR:$DAPHNE_SHARE:$LD_LIBRARY_PATH

if [ "$1" = "-fullscreen" ]; then
    FULLSCREEN="-fullscreen"
    shift
fi

if [ -z $1 ] ; then
	echo "Specify a game to try: "
	echo
	echo "\t$0 [-fullscreen] <gamename>"
	echo

        echo -n "Games available: "
	for game in $(ls $DAPHNE_SHARE/singe/); do
        	echo -n "$game "
	done
	echo
	exit

fi

#strace -o strace.txt \
./$DAPHNE_BIN singe vldp \
$FULLSCREEN \
-framefile $DAPHNE_SHARE/singe/$1/$1.txt \
-script $DAPHNE_SHARE/singe/$1/$1.singe \
-homedir $DAPHNE_SHARE \
-datadir $DAPHNE_SHARE \
-sound_buffer 2048 \
-noserversend \
-x 800 \
-y 600 


EXIT_CODE=$?

if [ "$EXIT_CODE" -ne "0" ] ; then
	if [ "$EXIT_CODE" -eq "127" ]; then
		echo ""
		echo "Daphne failed to start."
		echo "This is probably due to a library problem."
		echo "Run ./daphne.bin directly to see which libraries are missing."
		echo ""
	else
		echo "DaphneLoader failed with an unknown exit code : $EXIT_CODE."
	fi
fi
