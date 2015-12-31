FROM ruby:2.3-slim
MAINTAINER zakuro


RUN mkdir /dotfiles
WORKDIR /dotfiles

COPY Gemfile /dotfiles/
COPY Gemfile.lock /dotfiles/
RUN bundle install

COPY . /dotfiles

ENV TARGET full
cmd ["/bin/bash"]
