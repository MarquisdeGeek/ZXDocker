#!/bin/bash

SRC_IMAGE=z88dk
SRC_FOLDER=/src/examples/spectrum

DEST_IMAGE=emulates/zx
DEST_FOLDER=/home/user/zx/src/tap


# Assume there's only 1 running container
SRC_CONTAINER_ID=`docker container ls |grep -Po "\K[^\s]*\s+${SRC_IMAGE}" | cut -d' ' -f1`
DEST_CONTAINER_ID=`docker container ls |grep -Po "\K[^\s]*\s+${DEST_IMAGE}" | cut -d' ' -f1`

while getopts ":s:d:" FLAG; do
  case "$FLAG" in
        s) # change container (src)
                SRC_CONTAINER_ID=$OPTARG
                ;;
        d) # change container (dest)
                DEST_CONTAINER_ID=$OPTARG
                ;;
  esac
done

shift $((OPTIND-1))  #This tells getopts to move on to the next argument.
FILENAME=$1

if [ "$FILENAME" = "" ]; then
  echo "Please specify a filename..."
  exit -1;
elif [ "$FILENAME" = "ls" ]; then
  docker exec $SRC_CONTAINER_ID ls /src/examples/spectrum/ | grep .tap
  exit 0;
fi


TEMP_FILE=`mktemp`

docker cp $SRC_CONTAINER_ID:/$SRC_FOLDER/$FILENAME $TEMP_FILE
docker cp $TEMP_FILE  $DEST_CONTAINER_ID:/$DEST_FOLDER/$FILENAME

rm $TEMP_FILE
