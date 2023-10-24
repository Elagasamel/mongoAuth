#!/bin/bash
source ./config.sh



mongo --port $port <<EOF
use admin
db.createUser({user: "$adminUsername", pwd: "$adminPassword", roles: ['userAdminAnyDatabase']})
db.auth('$adminUsername', '$adminPassword')
db.shutdownServer()
exit
EOF

# Change transitionToAuth: true to transitionToAuth: false
sed -i 's/transitionToAuth: true/transitionToAuth: false/' ./database/rs0.conf

# Change authorization: disabled to authorization: enabled
sed -i 's/authorization: disabled/authorization: enabled/' ./database/rs0.conf

# Change enableLocalhostAuthBypass: true to enableLocalhostAuthBypass: false
sed -i 's/enableLocalhostAuthBypass: true/enableLocalhostAuthBypass: false/' ./database/rs0.conf

echo "Mongod service is now donw please make sure to run startMongoDB.sh ... "