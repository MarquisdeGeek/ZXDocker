
# ZX Docker

This is a simple container for developing BASIC or assembly software on the Sinclair ZX Spectrum. It contains the
ZEsarUX emulator, 6809 pasmo, and zmakebas - a basic->tap converter.

It has only been tested on Linux.


# Docker creation

First, you need to create a container which can be done by running the script:

```
./0-build.sh
```

WARNING: This also opens your xhost on local to accept graphic traffic from the container

Secondly, with a valid container run:

```
./1-run.sh
```

You will then be dropped into a (root) shell in the Docker container.


# Doing ZX stuff

There are a couple of sample progams in `src` which can be build, and automatically run under the
emulator with:

```
./doasm.sh
```

for a simple 'dump graphics to the screen' assembly program, held in `src/asm/test`. Pass a filename to this program
to assembly other code. The resultant binary is written to `out/src/asm/test/main.asm.tap`

```
./dobas.sh
```

to convert a plain text BASIC program into a TAP file, written to `out/src/bas/test.tap`.

And finally, run any existing .tap files with the wrapper script of:

```
./dotap.sh
```

Because the container mounts a directory on the host machine, you can edit the source using
whatever tools feel good, without having to install them into the container.


# Interacting with the container

The Docker Docs contain all you need. For cheaters....

## Copying a file from the container to the host

1. Determine the ID (or name) of the running container
```
r$ docker ps
CONTAINER ID   IMAGE         COMMAND       CREATED          STATUS          PORTS     NAMES
9ce1fcb8585c   emulates/zx   "/bin/bash"   21 minutes ago   Up 21 minutes             upbeat_engelbart
```

2. Issue a copy command, indicating the source (in container) snd destination (on host)

```
docker cp 9ce1fcb8585c:/root/zx/out/src/bas/test.tap host_local_file.tap
```

#  Ending the session

Remove the xhost access rights with

```
./2-end.sh
```



