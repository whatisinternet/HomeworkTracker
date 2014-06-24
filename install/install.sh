#!/bin/bash

echo 'Setup the directories'
mkdir ~/HomeworkTracker
mkdir ~/HomeworkTracker/projects
mkdir ~/HomeworkTracker/projects/Homework

gem install listen
gem install yaml

_mydir="$(pwd)"
cp _mydir ~/HomeworkTracker/projects/Homework

ruby ~/HomeworkTracker/projects/Homework/main.rb start

echo 'Creating aliases for Homework'
echo "\nalias homework='ruby ~/HomeworkTracker/projects/Homework/main.rb \$1 \$2'">>~/.bash_aliases
source ~/.bash_aliases
clear
echo "Setup complete! Restart your terminal and try a command like 'homework create [my project name]"
