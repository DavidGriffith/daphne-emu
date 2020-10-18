Daphne: the First Ever Multiple Arcade Laserdisc Emulator
=========================================================

Daphne, the First Ever Multiple Arcade Laserdisc Emulator is a program 
that lets one play the original versions of many laserdisc arcade games 
on one's PC.

The official website for Daphne is http://www.daphne-emu.com.

---

As development for Daphne has stopped, this repository is intended as 
something of a continuation until the author decides to do something 
official.

## Compiling Daphne on Linux

These instructions will work to get Daphne built on a machine using an 
amd64 processor.  I'm not sure anymore how to get Daphne compiled for 
32-bit Linux.

    cd src/vldp2
    ./configure --disable-accel-detect
    make -f Makefile.linux_x64
    cd ../game/singe
    make -f Makefile.linux_x64
    cd ../..
    ln -s Makefile.vars.linux_x64 Makefile.vars
    make
    cd ..
    mkdir -p ~/.daphne
    cp -a pics sound ~/.daphne/

### Missing libraries?

Cutting and pasting the following in a Debian GNU/Linux system (or
derivative), will install all prerequisite development libraries.

    sudo apt install libsdl-dev libglew-dev libvorbis-dev libsdl-image1.2-dev libsdl-ttf2.0-dev

## Laserdisc images and ROMs

The laserdisc and game ROMs necessary to play a game are not included
here. You'll need to buy those from [Digital
Leisure](http://digitalleisure.com) and copy them into
`~/.daphne/vldp_dl/` and `~/.daphne/roms`, respectively.

If you do not install them, you'll get an error message like:

    ROM dl_f2_u1.bin couldn't be found in roms/lair/, or in ./roms/lair.zip

### SINGE based game files

Game data using the singe plugin should be copied into `~/.daphne/singe/`
within a sub-diretory name matching the game title.

The primary `.singe` and `.txt` framefiles should also match this naming
convention within the game sub-directory.

    ~/.daphne/singe/maddog/maddog.singe
    ~/.daphne/singe/maddog/maddog.txt

## Running Daphne or SINGE

This version of daphne comes with simple command line frontends:

    ./run.sh lair
    ./singe.sh maddog

In order to | press this
------------|-----------
start a game| 5 5 1
play a game | arrow keys, ctrl, alt

SINGE games may utilise mouse control.

For a list of all possible keys, please see [the daphne wiki](https://www.daphne-emu.com:9443/mediawiki/index.php/input). 


### Why a new frontend?

Daphne is highly dependent on a front-end for ease of use.
Unfortunately the standard front-end is closed-source. I've been
working off and on to create a new graphical front-end. In the
meantime, I've provided a shell script that works for most of the
games: `run.sh`. It looks for stuff in `$HOME/.daphne`. Footage and
audio for Space Ace, Dragon's Lair 1 and 2, and Thayer's Quest are
found in `$HOME/.daphne/vldp_dl`. The others are found in
`$HOME/.daphne/vldp`. This script takes care of those differences. The
reason for this weirdness is how the old front end set things up. It
would download the footage and audio for those games if you inserted a
DVD of the same title and store it in `vldp_dl/`. Other stuff it
downloaded went into `vldp/`.
