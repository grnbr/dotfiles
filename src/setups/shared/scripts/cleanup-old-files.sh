#!/bin/bash

for dir in ~/downloads ~/Downloads ~/tmp; do
  [ -d "$dir" ] || continue
  find "$dir" -maxdepth 1 -type f -atime +45 -delete
done
