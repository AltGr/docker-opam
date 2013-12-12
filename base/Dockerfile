FROM ubuntu:latest
MAINTAINER Louis Gesbert <louis.gesbert@ocamlpro.com>
RUN apt-get -y install sudo pkg-config git build-essential m4 software-properties-common
RUN git config --global user.email "docker@example.com"
RUN git config --global user.name "Docker"
RUN apt-get -y install python-software-properties
RUN yes | add-apt-repository ppa:avsm/ppa
RUN apt-get -y update -qq
RUN apt-get -y install -qq ocaml ocaml-native-compilers camlp4-extra opam
ADD opam-installext /usr/bin/opam-installext
RUN adduser --disabled-password --gecos "" opam
RUN passwd -l opam
ADD opamsudo /etc/sudoers.d/opam
RUN chmod 440 /etc/sudoers.d/opam
USER opam
ENV HOME /home/opam
ENV OPAMVERBOSE 1
ENV OPAMYES 1
ADD opam-repository /home/opam/opam-repository
RUN opam init /home/opam/opam-repository
ADD packages /etc/opam-packages
ADD opamrun /usr/bin/opamrun
WORKDIR /home/opam
ENTRYPOINT ["/usr/bin/opamrun"]
