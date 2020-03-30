#!/usr/bin/zsh

if [[ ! $(which deno > /dev/null) ]]
then
    curl -fsSL https://deno.land/x/install/install.sh | sh
fi

deno --allow-env --allow-run --allow-read --allow-write bootstrap.ts
