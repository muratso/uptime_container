#!/bin/bash

set -eu

echo "ruby				ALL = (ALL) NOPASSWD: ALL" > /etc/sudoers.d/ruby
chmod 0440 /etc/sudoers.d/ruby
