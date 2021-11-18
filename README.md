
# dkarm_gba_docker

a docker image for building gba games with devkitarm, including a bunch of tools and utilities to build various projects

## includes
+ Build tools (`git`, `c`, `c++`, `wget`, `curl`)
+ DevkitARM (`gba-dev`)
+ Asset packers (`crunch`, `Tiled2GBA`)
+ Nelua (`nelua`)
+ D (`dub`, `dmd`, `ldc2`)

## build
```sh
docker build --pull -t dkarm_gba_docker:local .
```

## usage

to open a shell inside the container with the current directory mounted
```sh
docker run -it --rm -v $(pwd):/source dkarm_gba_docker:local -l -c bash
```

for example, to build duster with this docker image:
```sh
docker run -it --rm -v $(pwd):/source dkarm_gba_docker:local -l -c "pushd . && git submodule update --init --recursive && cd src/DusterGBA && make clean && make build && popd"
```