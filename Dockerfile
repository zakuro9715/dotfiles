FROM ruby:2.3-slim
MAINTAINER zakuro


RUN mkdir /dotfiles
WORKDIR /dotfiles

RUN apt-get update && apt-get install -y zsh && rm -rf /var/lib/apt/lists/*

COPY Gemfile /dotfiles/
COPY Gemfile.lock /dotfiles/
RUN bundle install

COPY . /dotfiles

cmd ["/bin/bash"]
