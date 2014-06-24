HomeworkTracker
===============

Homework Tracker was created to provide an easy to use and understand wrapper for the git. The project is aimed at students not in computer science. The project does not follow some of the most recommended practices with regards to git. e.g. meaningful commits.

The idea is to provide students with something easy to use with low overhead.

This project was created using HomeworkTracker as the git manager. For example commits see commits on this project.

Current Requirements:
---------------------
* Unix based system (untested on Mac OSX)
* RVM
* Ruby 2.1
* some knowledge of bash

Usage:
------

#### Create a project:
homework create [project_name]

#### Automagically version (reversable, version set on save):
homework watch [project_name]

#### Create a reversable version:
homework save [project_name]

#### Create a non* reversable version:
homework save! [project_name]

#### Create a reverse a version:
homework save [project_name]

TODO:
-----
* Remote git repo support
* Monitor all projects at once
* GUI
* Windows

Features and options are subject to change at any time
