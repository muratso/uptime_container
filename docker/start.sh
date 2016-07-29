#!/bin/bash

sysctl vm.overcommit_memory=1
sudo service redis-server start

cd /home/ruby/uptime_checker
foreman start
