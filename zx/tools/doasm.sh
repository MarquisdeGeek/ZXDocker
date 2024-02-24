#!/bin/bash

PROGRAM=$1

if [ "$PROGRAM" == "" ]; then
  PROGRAM=src/asm/test/main.asm
fi

WORKPATH=out/`dirname $PROGRAM`
OUTFILEBASE=$WORKPATH/`basename $PROGRAM`

mkdir -p $WORKPATH 2>/dev/null

pasmo -1  --tapbas $PROGRAM $OUTFILEBASE.tap >$OUTFILEBASE.lst


if [ $? -eq 0 ]; then
  ./emu.sh $OUTFILEBASE.tap
fi
