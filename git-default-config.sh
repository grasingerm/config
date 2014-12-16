#!/bin/bash

git config --global user.name "Matthew Grasinger"
git config --global user.email "grasingerm@gmail.com"
git config --global push.default=matching

cp .gitmessage.txt ~/
git config --global commit.template ~/.gitmessage.txt