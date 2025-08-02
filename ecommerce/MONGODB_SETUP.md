# MongoDB Atlas Setup for Production

## Step 1: Create MongoDB Atlas Account
1. Go to [MongoDB Atlas](https://www.mongodb.com/atlas)
2. Sign up for a free account
3. Create a new project

## Step 2: Create a Cluster
1. Click "Build a Database"
2. Choose "FREE" tier (M0)
3. Select your preferred cloud provider (AWS, Google Cloud, or Azure)
4. Choose a region close to your Heroku app
5. Click "Create"

## Step 3: Set Up Database Access
1. Go to "Database Access" in the left sidebar
2. Click "Add New Database User"
3. Create a username and password (save these!)
4. Select "Read and write to any database"
5. Click "Add User"

## Step 4: Set Up Network Access
1. Go to "Network Access" in the left sidebar
2. Click "Add IP Address"
3. Click "Allow Access from Anywhere" (for production)
4. Click "Confirm"

## Step 5: Get Connection String
1. Go back to "Database" in the left sidebar
2. Click "Connect"
3. Choose "Connect your application"
4. Copy the connection string
5. Replace `<password>` with your database user password
6. Replace `<dbname>` with your database name (e.g., `mern_ecommerce`)

## Step 6: Set Environment Variable in Heroku
```bash
heroku config:set MONGO_URI="your-mongodb-atlas-connection-string" --app ecommerce-test-agents
```

## Example Connection String Format:
```
mongodb+srv://username:password@cluster0.xxxxx.mongodb.net/mern_ecommerce?retryWrites=true&w=majority
```

## Step 7: Test the Connection
After deployment, check your Heroku logs:
```bash
heroku logs --tail --app ecommerce-test-agents
```

You should see successful database connection messages. 