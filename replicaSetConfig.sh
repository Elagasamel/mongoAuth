#!/bin/bash

source ./config.sh


mongo --port $port <<EOF
rs.initiate()
rs.conf()
exit
EOF
