#!/bin/bash

PROGRAM=$1

if [ "$PROGRAM" == "" ]; then
  PROGRAM=src/bas/test.bas
fi

# If you're lazy then omit the path, and this code will
# assume the code is in the usual place
if [ ! -f $PROGRAM ]; then
  PROGRAM=src/bas/$PROGRAM
fi

WORKPATH=out/`dirname ${PROGRAM%.*}`
OUTFILEBASE=out/${PROGRAM%.*}

mkdir -p $WORKPATH 2>/dev/null


zmakebas -o $OUTFILEBASE.tap $PROGRAM

if [ $? -eq 0 ]; then
  ./emu.sh $OUTFILEBASE.tap
fi

