#!/bin/bash

port=27021
adminUsername="medamin"
adminPassword="imaxeam001"

mongo --port $port <<EOF
use admin
db.createUser({user: "$adminUsername", pwd: "$adminPassword", roles: ['userAdminAnyDatabase']})
db.auth('$adminUsername', '$adminPassword')
EOF

