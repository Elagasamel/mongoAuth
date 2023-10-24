#!/bin/bash

export port=27012
export adminPassword="123456"
export adminUsername="medamin"
export BASE_DB_PATH="./database"
export SECURITY_KEY_PATH="security.key"
export DB_PATH="./data/db"
export DATA_DB_PATH="$BASE_DB_PATH/$DB_PATH"
export REPLICATION_NAME="rs0"
export REPLICATION_NAME_CONFIG_FILE="$REPLICATION_NAME.conf"