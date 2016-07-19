#!/bin/bash

sudo service redis-server start

cd /home/ruby/uptime_checker
foreman start
