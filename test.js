const axios = require("axios");
const crypto = require("crypto");
const { MongoClient } = require("mongodb");
const { type } = require("os");

async function replicateSearchIndexes() {

//    const atlasAdminUrl = `{{base_url}}/api/atlas/{{version}}/groups/{{ProjectID}}/clusters/{{CLUSTER-NAME}}/fts/indexes`;
    const baseURLSource = "mongodb+srv://aravindar:aravindar@prod.gmuxd.mongodb.net/?retryWrites=true&w=majority&appName=Prod";
    const baseURLTarget = "mongodb+srv://aravindar:aravindar@cluster1.gmuxd.mongodb.net/?retryWrites=true&w=majority&appName=Prod";

    const clientSource = await MongoClient.connect(baseURLSource, {
        useNewUrlParser: true,
        useUnifiedTopology: true,
    });

    const clientTarget = await MongoClient.connect(baseURLTarget);

    const dbSource = clientSource.db();

    // Get the list of databases
    const dbsSource = await dbSource.admin().listDatabases();

    // Iterate through each database
    for (const database of dbsSource.databases) {
        // Skip local and admin databases
        if (database.name === "local" || database.name === "admin") {
            continue;
        }

        // Switch to the current database
        const currentDb_source = clientSource.db(database.name);
        const currentDb_target = clientTarget.db(database.name);

        // Get the collection names
        const collectionNames = await currentDb_source.listCollections().toArray();

        // Iterate through each collection and list the search indexes
        for (const collectionName of collectionNames) {

            collectionSource = currentDb_source.collection(collectionName.name)
            const searchIndexes = await collectionSource.listSearchIndexes().toArray();

            if (searchIndexes.length > 0) {
                const collectionTarget = currentDb_target.collection(collectionName.name)
                for (const index of searchIndexes) {
                        const indexNew = {
                                name: index.name,
                                type: index.type,
                                definition: index.latestDefinition
                        }
                        console.log(`[${new Date().toISOString()}] Attempting to create the index in the collection ${collectionName.name}:\n${JSON.stringify(indexNew)}`);
                        try{
                                const status = await collectionTarget.createSearchIndex(indexNew);
                                console.log(`[${new Date().toISOString()}] Successfully created the index ${indexNew.name} in the target collection ${collectionTarget}. Waiting for 1 minute for index build to proceed`);
                                await new Promise(resolve => setTimeout(resolve, 60000));
                        }
                        catch (error) {
                                console.error(`[${new Date().toISOString()}] ${error}`);
                        }
                }
            }
        }
    }

    // Close the MongoDB connections
    await clientSource.close();
    await clientTarget.close();
}

// function generateDigest(publicKey, privateKey) {
//   const timestamp = Math.floor(Date.now() / 1000);
//   const nonce = crypto.randomBytes(16).toString("hex");
//   const message = `${publicKey}:${timestamp}:${nonce}:${privateKey}`;
//   const digest = crypto.createHash("md5").update(message).digest("hex");
//   return `${publicKey}:${timestamp}:${nonce}:${digest}`;
// }

replicateSearchIndexes();
