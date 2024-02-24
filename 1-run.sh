#!/bin/bash

# If you change the username in Dockerfile, remember to change it here
USER_NAME=user

docker run -i -e DISPLAY=:0.0 --device /dev/snd -v /dev/snd:/dev/snd  -v /tmp/.X11-unix/:/tmp/.X11-unix/  -v ./zx/src:/home/$USER_NAME/zx/src -t emulates/zx /bin/bash

