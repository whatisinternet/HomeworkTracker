#!/bin/bash

echo 'Setup the directories'
mkdir ~/projects
mkdir ~/HomeworkTracker
mkdir ~/HomeworkTracker/projects

gem install listen
gem install yaml

echo 'Creating aliases for Homework'
echo "\nalias homework='ruby ~/HomeworkTracker/projects/Homework/main.rb \$1 \$2'">>~/.bash_aliases
source ~/.bash_aliases
clear
echo "Setup complete!"
