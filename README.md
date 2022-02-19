
# devkitarm gba for docker

a docker image for building gba games with devkitarm.
comes in **multiple flavors**: a **base image**, and an enhanced **dusk image** including a bunch of tools and utilities to build various projects.

what most people are looking for is the **base** flavor. see below for what is included, and for instructions to build the image locally.
## includes

### base devkit (default)
+ Build tools (`devkitarm`, `git`, `make`, `c`, `c++`, `wget`, `curl`)
+ DevkitARM (`gba-dev`)
### dusk addons (`dusk` flavor only)
+ Asset packers (`crunch`, `Tiled2GBA`)
+ Nelua (`nelua`)
+ D (`dub`, `dmd`, `ldc2`)

## build
this is how you build the docker image:

### base devkit (recommended)
```sh
docker build -f base/Dockerfile --pull -t dkarm_base:local .
```

### dusk devkit
```sh
docker build -f dusk/Dockerfile --pull -t dkarm_dusk:local .
```

## usage
to open a shell inside the container with the current directory mounted
```sh

docker run -it --rm -v $(pwd):/source --user "$(id -u):$(id -g)" dkarm_base:local -l -c bash
```

for example, to build [duster](https://github.com/redthing1/duster) with the dusk flavor docker image:
```sh
pushd . && git submodule update --init --recursive && cd src/DusterGBA && make clean && make build && popd
```
