This script is for migrating Search indexes from one MongoDB Atlas cluster to another. 

When performing a Live Migration, MongoDB Atlas does not copy the search indexes. Follow the below steps to copy the search indexes.

Step 1: Create a database cluster in the new project. Create the new cluster with the same configuration as the existing one. The database version should be SAME.

Step 2: Create database users in the new project. Retain the same usernames and passwords to avoid additional config changes in the application.

Step 3: Verify and replicate if any change has been made to Backup policies in the original cluster.

Step 4: Perform Live migration of data to the new cluster from the old cluster. Follow the steps listed in https://www.mongodb.com/docs/atlas/import/c2c-pull-live-migration/

Step 5: Replicate the search indexes from the source cluster to the new cluster.

Run the below script once the live migration status shows ‘Initial Sync Complete’
execute 'npm install'
execute 'node replicateSearchIndexes.js'
