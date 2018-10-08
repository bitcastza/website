#!/bin/bash
set -e

URL=bitcast.co.za
PORT=1552

which ssh-agent || ( apt-get update -y && apt-get install openssh-client -y )
eval $(ssh-agent -s)
echo "$SSH_KEY" | tr -d '\r' | ssh-add - > /dev/null
mkdir ~/.ssh && chmod 700 ~/.ssh
echo "$SSH_ID" >> ~/.ssh/known_hosts

hugo
scp -r -P $PORT public/* $URL:/var/www/html/$URL
