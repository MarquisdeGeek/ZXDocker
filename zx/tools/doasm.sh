#!/bin/bash

PROGRAM=$1

if [ "$PROGRAM" == "" ]; then
  PROGRAM=src/asm/test/main.asm
fi

# If you're lazy then omit the path, and this code will
# assume the code is in the usual place
if [ ! -f $PROGRAM ]; then
  PROGRAM=src/asm/test/$PROGRAM
fi

WORKPATH=out/`dirname $PROGRAM`
OUTFILEBASE=$WORKPATH/`basename $PROGRAM`

mkdir -p $WORKPATH 2>/dev/null

pasmo -1  --tapbas $PROGRAM $OUTFILEBASE.tap >$OUTFILEBASE.lst


if [ $? -eq 0 ]; then
  ./emu.sh $OUTFILEBASE.tap
fi
