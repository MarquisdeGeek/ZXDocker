#!/bin/bash

DISPLAY=:0.0 xhost +local:*

docker build -t emulates/zx .

