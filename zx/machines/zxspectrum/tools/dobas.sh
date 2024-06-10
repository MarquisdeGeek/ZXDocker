#!/bin/bash

PROGRAM=$1
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )


if [ "$PROGRAM" == "" ]; then
  PROGRAM=src/bas/test.bas
fi

# If you're lazy then omit the path, and this code will
# assume the code is in the usual place
if [ ! -f $PROGRAM ]; then
  PROGRAM=src/bas/$PROGRAM
fi

echo "Loading program: $PROGRAM"


WORKPATH=out/`dirname ${PROGRAM%.*}`
OUTFILEBASE=out/${PROGRAM%.*}

echo "Determined output as: $OUTFILEBASE"


mkdir -p $WORKPATH 2>/dev/null

echo "Running zmakebas"
zmakebas -o $OUTFILEBASE.tap $PROGRAM

if [ $? -eq 0 ]; then
  echo "Running emulator"
  ${SCRIPT_DIR}/emu.sh $OUTFILEBASE.tap
fi

