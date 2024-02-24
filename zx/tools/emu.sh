#!/bin/bash

PROGRAM=$1

(CW=`pwd` && pushd contrib/ZEsarUX-X && ./zesarux --vo sdl  --ao null --machine 48k --tape $CW/$1; popd ) >/dev/null

