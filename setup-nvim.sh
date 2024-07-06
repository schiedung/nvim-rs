#!/bin/bash
if [ -x "$(command -v nvim)" ];
then
    mkdir -p ~/.config/nvim/tmp
    ln -s ${PWD}/nvim/init.lua ~/.config/nvim/init.lua
fi
