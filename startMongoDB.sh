#!/bin/bash

BASE_DB_PATH="./database"
SECURITY_KEY_PATH="security.key"
DB_PATH="./data/db"
DATA_DB_PATH="$BASE_DB_PATH/$DB_PATH"
REPLICATION_NAME="rs0"
REPLICATION_NAME_CONFIG_FILE="$REPLICATION_NAME.conf"


function navigate_dir(){

cd $1
echo "current path: $(pwd)"

}
# End Fn navigate_dir

function generate_mongod_config(){

echo "generating $BASE_DB_PATH/$REPLICATION_NAME_CONFIG_FILE"
echo "using default configurations, defaults could be refered from ./doumentations/mongod.conf"
# TODO generate private key for replica auth
cat <<EOF_RS_CONF_FILE_WR > $REPLICATION_NAME_CONFIG_FILE
# $REPLICATION_NAME_CONFIG_FILE
# for documentation of all options, see:
#   http://docs.mongodb.org/manual/reference/configuration-options/

# where to write logging data.
systemLog:
  destination: file
  logAppend: true
  path: ./mongod.log

# Where and how to store data.
storage:
  dbPath: $DB_PATH

# Replication
replication:
   replSetName: $REPLICATION_NAME

# Network interfaces
net:
  port: 27021
  bindIp: 127.0.0.1

# Security
security:
  keyFile: ./$SECURITY_KEY_PATH
  transitionToAuth: true
  authorization: disabled

# Extra params
setParameter:
   enableLocalhostAuthBypass: true

# EFO $REPLICATION_NAME_CONFIG_FILE
EOF_RS_CONF_FILE_WR

if [ -f "./$REPLICATION_NAME_CONFIG_FILE" ]; then

echo "created $REPLICATION_NAME_CONFIG_FILE"
else
echo "could not creat $REPLICATION_NAME_CONFIG_FILE !"
fi

}
# End Fn generate_mongod_config

function stop_mongod_mongo_process(){

echo "trying to stop monngod and mongo process"
# List existing mongod process
pgrep mongod
# Kill existing process if has.
pkill mongod

# List existing mongo process
pgrep mongo
# Kill existing process if has.
pkill mongo

}
# End Fn stop_mongod_mongo_process

function run_mongo_process(){

echo "runing: mongod --config $REPLICATION_NAME_CONFIG_FILE"
echo "Ctrl + C to quit"
mongod --config $REPLICATION_NAME_CONFIG_FILE

}
# End Fn run_mongo_process

function create_security_key(){

openssl rand -base64 756 > "$BASE_DB_PATH/$SECURITY_KEY_PATH"
chmod 400 "$BASE_DB_PATH/$SECURITY_KEY_PATH"

echo -e "SECURITY_KEY_PATH: created $BASE_DB_PATH/$SECURITY_KEY_PATH"
}
# End Fn create_security_key


function deploy_defaults(){
  echo "deploy_defaults"
}
# End Fn deploy_defaults


echo "checking for $DB_PATH and $BASE_DB_PATH existance"
if [ -d "$DATA_DB_PATH" ]; then
echo "database path: $DATA_DB_PATH found"

else
echo "database path: $DATA_DB_PATH not found ! creating directory tree"

mkdir -p "$DATA_DB_PATH"

fi

echo "checking $SECURITY_KEY_PATH file existance"
if [ ! -f "$BASE_DB_PATH/$SECURITY_KEY_PATH" ]; then
echo "$SECURITY_KEY_PATH not found !"
create_security_key
fi


navigate_dir $BASE_DB_PATH


echo "checking $BASE_DB_PATH/$REPLICATION_NAME_CONFIG_FILE file existance"
if [ ! -f "./$REPLICATION_NAME_CONFIG_FILE" ]; then
echo "$REPLICATION_NAME_CONFIG_FILE not found !"
generate_mongod_config
fi


echo "@ $(pwd)"
# stop_mongod_mongo_process
run_mongo_process
