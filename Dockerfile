FROM ubuntu:latest
MAINTAINER Louis Gesbert <louis.gesbert@ocamlpro.com>
RUN apt-get -y install sudo pkg-config git build-essential m4 software-properties-common
RUN git config --global user.email "docker@example.com"
RUN git config --global user.name "Docker"
RUN apt-get -y install python-software-properties
RUN yes | add-apt-repository ppa:avsm/ppa
RUN apt-get -y update -qq
RUN apt-get -y install -qq ocaml ocaml-native-compilers camlp4-extra opam
RUN adduser --disabled-password --gecos "" opam
RUN passwd -l opam
ADD opamsudo /etc/sudoers.d/opam
RUN chmod 440 /etc/sudoers.d/opam
USER opam
ENV HOME /home/opam
ENV OPAMVERBOSE 1
ENV OPAMYES 1
WORKDIR /home/opam
ADD opam-installext /usr/bin/opam-installext
ADD opamrun /usr/bin/opamrun
ENTRYPOINT ["/usr/bin/opamrun"]
