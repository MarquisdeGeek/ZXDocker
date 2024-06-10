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
mkdir -p $WORKPATH 2>/dev/null
OUTFILEBASE=out/${PROGRAM%.*}

echo "Determined output as: $OUTFILEBASE"


# If you prefer labels mode, I use this variations
#${SCRIPT_DIR}/../../../contrib/zxtext2p -o $OUTFILEBASE.p -l -s 1 -i 1 $PROGRAM

${SCRIPT_DIR}/../../../contrib/zxtext2p -o $OUTFILEBASE.p $PROGRAM

if [ $? -eq 0 ]; then
  echo "Running emulator"
  ${SCRIPT_DIR}/emu.sh $OUTFILEBASE.p
fi

