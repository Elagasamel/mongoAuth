# mongoAuth

This project provides scripts to configure **MongoDB authentication** with a **replica set**. It includes all necessary steps for setting up MongoDB, initializing a replica set, enabling authentication, and verifying the setup.

---

## Prerequisites
- MongoDB installed
- Bash shell (Linux / macOS)
- Sufficient permissions to run MongoDB processes
- Basic understanding of MongoDB replica sets and authentication

---

## Setup Steps

### Step 1: Configuration
1. Open the `config.sh` file  
2. Edit the configuration variables according to your environment:
   - MongoDB data directory
   - Log file paths
   - Replica set name
   - Ports and authentication settings

---

### Step 2: MongoDB Initialization

1. Start MongoDB with the initial configuration:
   ```bash
   ./startMongoDB.sh
