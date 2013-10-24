#!/bin/sh

cat "./$1" | grep '(\d' | sed 's/^ *//g' | while read line
do
  gem=`echo $line | cut -d '(' -f1`
  version=`echo $line | cut -d '(' -f2 | sed 's/.$//'`
  latest_version=`curl -s https://rubygems.org/api/v1/versions/$gem.json | egrep -oh 'number":"(\w|\.)*"' | head -n1 | cut -d ":" -f2 | sed 's/"//g'`
  if [ "$version" != "$latest_version" ]; then
    echo "You're using: $gem $version. The latest version is $latest_version"
  fi
done  
