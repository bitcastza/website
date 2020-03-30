#!/bin/bash
set -e

CONNECTION_URI=website@sftp.bitcast.co.za
PORT=1552

hugo
echo "Generated. Now run the following to upload the files:"
echo "sftp -P $PORT $CONNECTION_URI"
echo "mput -r public/* data/"
