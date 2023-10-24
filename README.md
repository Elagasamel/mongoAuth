# mongoAuth



#### Step 1

1/ Open "config.sh" file 

2/ edit necessary  config variables 



#### Step 2

1/ Run the "startMongoDB.sh" to run mongod with necessary config 

2/ Make sure the "startMongoDB.sh" is up . Run "replicaSetConfig.sh" to configure replica set 

3/ Run "useAuth.sh" . The mongod script will be automatically down (if not make sure to stop the mongod process)

4/ Run "startMongoDB.sh"