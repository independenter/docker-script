#!/bin/sh
#author:donghui

docker ps -a -q|xargs  docker start
