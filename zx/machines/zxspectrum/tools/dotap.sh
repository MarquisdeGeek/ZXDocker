#!/bin/bash

PROGRAM=$1
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if [ "$PROGRAM" == "" ]; then
  PROGRAM=src/tap/hello.tap
fi

# If you're lazy then omit the path, and this code will
# assume the code is in the usual place
if [ ! -f $PROGRAM ]; then
  PROGRAM=src/tap/$PROGRAM
fi

echo "Loading program: $PROGRAM"

echo "Running emulator"
${SCRIPT_DIR}/emu.sh $PROGRAM
