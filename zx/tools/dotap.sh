#!/bin/bash

PROGRAM=$1
ROMPATH=roms

if [ "$PROGRAM" == "" ]; then
  PROGRAM=src/tap/hello.tap
fi

./emu.sh $PROGRAM
