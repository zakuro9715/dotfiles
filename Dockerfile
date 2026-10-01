FROM ubuntu:26.04

RUN apt update -yqq && apt install -yqq sudo zsh

ENV HOME=/home/zakuro
ENV DOTFILES=${HOME}/src/github.com/zakuro9715/dotfiles
WORKDIR ${HOME}

ARG USERNAME=zakuro
ARG UID=1002
RUN useradd -m -u $UID $USERNAME
RUN echo "$USERNAME ALL=NOPASSWD: ALL" >> /etc/sudoers


COPY . $DOTFILES
WORKDIR $DOTFILES

RUN zsh bootstrap.zsh
USER ${UID}

WORKDIR ${HOME}
CMD ["zsh"]
