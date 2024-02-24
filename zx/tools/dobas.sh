#!/bin/bash

PROGRAM=$1

if [ "$PROGRAM" == "" ]; then
  PROGRAM=src/bas/test.bas
fi

WORKPATH=out/`dirname ${PROGRAM%.*}`
OUTFILEBASE=out/${PROGRAM%.*}

mkdir -p $WORKPATH 2>/dev/null


zmakebas -o $OUTFILEBASE.tap $PROGRAM

if [ $? -eq 0 ]; then
  ./emu.sh $OUTFILEBASE.tap
fi

