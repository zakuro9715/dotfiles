FROM golang:1.15-buster

RUN  apt update -yqq && apt install -yqq sudo zsh

ENV HOME /home/zakuro
ENV DOTFILES ${HOME}/src/github.com/zakuro9715/dotfiles
WORKDIR ${HOME}

ARG UID=1000
RUN useradd -m -u ${UID} docker


COPY . $DOTFILES
WORKDIR $DOTFILES

RUN zsh bootstrap.zsh
USER ${UID}

WORKDIR ${HOME}
CMD ["zsh"]
