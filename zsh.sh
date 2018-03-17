#!/bin/bash

ZSH="/root/.zshrc"

sed -i "s/robbyrussell/darkblood/g" $ZSH
sed -i "11i DISABLE_UPDATE_PROMPT=true" $ZSH
sed -i "s/# export UPDATE_ZSH_DAYS=13/export UPDATE_ZSH_DAYS=7/g" $ZSH
sed -i "s/# export LANG=en_US.UTF-8/export LANG=en_US.UTF-8/g" $ZSH
