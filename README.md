Builds a docker container with a basic Ubuntu, OPAM and a customisable set
of OPAM packages installed.

## instructions:

* install Docker (`curl -s http://get.docker.io/ubuntu/ | sudo sh` on Ubunty or see [http://docs.docker.io/en/latest/installation/])
* add the needed users to the `docker` group
* clone this repo
* run the build: `./make.sh opamdock/browse ocp-browser ocp-index curses`
First argument is the name of your docker container, second is the default command to run, and then a list of opam packages.
This will make a local mirror of the needed package archives, then create the docker container
* run your container: `docker run opamdock/browse`
