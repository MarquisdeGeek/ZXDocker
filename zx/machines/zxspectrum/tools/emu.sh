#!/bin/bash

PROGRAM=$1
#EMU_DRIVER_GFX="--vo sdl"
EMU_DRIVER_GFX="--vo xwindows --disableshm"

(CW=`pwd` && pushd ../../contrib/ZEsarUX-X && ./zesarux $EMU_DRIVER_GFX --ao null --machine 48k --tape $CW/$1; popd ) >/dev/null

