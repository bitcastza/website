#!/bin/bash
set -e

CONNECTION_URI=website@sftp.bitcast.co.za
URL=bitcast.co.za
PORT=1552

which ssh-agent || ( apt-get update -y && apt-get install openssh-client -y )
eval $(ssh-agent -s)
echo "$SSH_KEY" | tr -d '\r' | ssh-add - > /dev/null
mkdir ~/.ssh && chmod 700 ~/.ssh
echo "$SSH_ID" >> ~/.ssh/known_hosts

hugo
scp -C -o ControlMaster=auto -o ControlPersist=60s -o StrictHostKeyChecking=no -r -P $PORT public/* $CONNECTION_URI:/var/www/html/$URL

ssh -C -o ControlMaster=auto -o ControlPersist=60s -o StrictHostKeyChecking=no -p $PORT $CONNECTION_URI "chown -R www-data:www-data /var/www/html/$URL"
