#!/bin/bash
for f in home/*
do
  ln -sf "$(cd $(dirname $f) && pwd)/$(basename $f)" "$HOME/.${f##*/}"
done
