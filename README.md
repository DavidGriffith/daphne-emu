
Daphne: the First Ever Multiple Arcade Laserdisc Emulator
=========================================================

<img src=https://raw.githubusercontent.com/baarreth/daphne/d25172eef41760559f84327672974b22aaa4e9a2/pics/daphne.gif />

Daphne, the First Ever Multiple Arcade Laserdisc Emulator is a program 
that lets one play the original versions of many laserdisc arcade games 
on one's PC.

The official website for Daphne is http://www.daphne-emu.com.

This is a fork from [DavidGriffith's work](https://github.com/DavidGriffith/daphne), and we are pretty outdated.
If you want to use a newer version, you should use the SDL2 port from [DirtBagXon](https://github.com/DirtBagXon/hypseus-singe).

### Here is the link: https://github.com/DirtBagXon/hypseus-singe

There is no good reason to use this outdated version, except if you are
having bugs with the SDL2 version, you are impatient and you have fun by messing with outdated code (which was my case). 

---

## Compiling Daphne on Linux (64-bit)

    cd src
    ./compile_everything.sh

This script will exit on the first error. So, pay attention on its instructions and execution.

### Missing libraries?

Cutting and pasting the following in a Debian GNU/Linux system (or
derivative), will install all prerequisite development libraries.

    sudo apt install libsdl-dev libglew-dev libvorbis-dev libsdl-image1.2-dev libsdl-ttf2.0-dev

## Where to place this project in your computer

I suggest you create a folder called "games" in your home, another called "arcade" inside it,
and download this project inside it via git-clone.
So, you will have a "~/games/arcade/daphne/", which will have the binary after compiling it.

The current practice is to place the disc images, roms and other media in "~/.daphne" (a hidden folder),
but I really don't think it is a good idea for several reasons.
**You will need to copy or move "daphne/pics" and "daphne/sound" into this hidden folder**.
I suggest you to place the singe games (such as Mad Dog McCree) in "~/games/arcade/daphne/singe/" and
vldp games (such as Dragon's Lair) in "~/games/arcade/daphne/vldp_dl/".

*ATTENTION*: Daphne needs the games to have specific names and specific places to run.
So Dragon's Lair frames goes in "~/games/arcade/daphne/vldp_dl/lair/", and its rom at
"~/games/arcade/daphne/vldp_dl/roms/". The standard Daphne's name for its rom is "lair.zip"
(in Mame this **exact same rom** is called "dlair.zip").
Following this pattern, Mad Dog McCree frames should be placed at "~/games/daphne/singe/maddog".

Obviously you can change this pattern...

Anyway, there are two good scripts from DavidGriffith called "run.sh" and "singe.sh",
which will run Dragon's Lair and Mad Dog McCree, respectively. Open the scripts and study them (they are
point to "~/.daphne").
I am changed them a little and renamed them to "run_vldp.sh" and "run_singe.sh"
(which are pointing to "~/games/arcade/daphne"). Their settings worked fine on my raspberry pi 4b.

--------------------------------

If you are still having a hard time to configure it all, read the following text from 
DavidGriffith.

--------------------------------

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
