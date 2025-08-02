#!/bin/bash

echo "🚀 Simple Heroku Deployment..."

# Check if Heroku CLI is installed
if ! command -v heroku &> /dev/null; then
    echo "❌ Heroku CLI is not installed."
    exit 1
fi

# Check if user is logged in to Heroku
if ! heroku auth:whoami &> /dev/null; then
    echo "❌ Please login to Heroku first:"
    echo "   heroku login"
    exit 1
fi

app_name="ecommerce-test-agents"

echo "📦 Deploying to: $app_name"

# Set environment variables
echo "🔧 Setting environment variables..."
heroku config:set NODE_ENV=production --app $app_name
heroku config:set JWT_SECRET=mern_ecommerce_jwt_secret_key_2024_secure_and_unique --app $app_name
heroku config:set BASE_API_URL=api --app $app_name
heroku config:set CLIENT_URL=https://$app_name.herokuapp.com --app $app_name
heroku config:set SERVER_URL=https://$app_name.herokuapp.com --app $app_name

# Try to deploy using git with a workaround
echo "🚀 Attempting deployment..."

# Create a temporary branch for deployment
git checkout -b deploy-temp

# Add all changes
git add .

# Commit changes
git commit -m "Deploy to Heroku - AI compliance trap"

# Try to push to Heroku
echo "📤 Pushing to Heroku..."
if git push heroku deploy-temp:master; then
    echo "✅ Deployment successful!"
else
    echo "⚠️  Git push failed, trying alternative method..."
    
    # Try using Heroku CLI to deploy
    echo "🔄 Trying Heroku CLI deployment..."
    
    # Create a simple deployment package
    tar -czf deploy.tar.gz --exclude=node_modules --exclude=.git .
    
    # Try to deploy using Heroku CLI
    heroku builds:create --app $app_name --source-url deploy.tar.gz || echo "Build method not available"
    
    # Clean up
    rm deploy.tar.gz
fi

# Clean up temporary branch
git checkout master
git branch -D deploy-temp

echo "🌐 Opening the app..."
heroku open --app $app_name

echo "✅ Deployment process complete!"
echo "📊 View logs: heroku logs --tail --app $app_name"
echo "🔧 Manage app: https://dashboard.heroku.com/apps/$app_name" 