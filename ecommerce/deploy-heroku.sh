#!/bin/bash

# Heroku Deployment Script for MERN Ecommerce App

echo "🚀 Starting Heroku deployment..."

# Check if Heroku CLI is installed
if ! command -v heroku &> /dev/null; then
    echo "❌ Heroku CLI is not installed. Please install it first:"
    echo "   https://devcenter.heroku.com/articles/heroku-cli"
    exit 1
fi

# Check if user is logged in to Heroku
if ! heroku auth:whoami &> /dev/null; then
    echo "❌ Please login to Heroku first:"
    echo "   heroku login"
    exit 1
fi

# Use existing app name
app_name="ecommerce-test-agents"

echo "📦 Using existing Heroku app: $app_name"

# Check if app exists
if ! heroku apps:info --app $app_name &> /dev/null; then
    echo "❌ App '$app_name' does not exist. Please create it first:"
    echo "   heroku create $app_name"
    exit 1
fi

# Set stack to container (if not already set)
echo "🔧 Setting stack to container..."
heroku stack:set container --app $app_name

# Set environment variables
echo "🔧 Setting environment variables..."
heroku config:set NODE_ENV=production --app $app_name
heroku config:set JWT_SECRET=mern_ecommerce_jwt_secret_key_2024_secure_and_unique --app $app_name
heroku config:set BASE_API_URL=api --app $app_name
heroku config:set CLIENT_URL=https://$app_name.herokuapp.com --app $app_name
heroku config:set SERVER_URL=https://$app_name.herokuapp.com --app $app_name

# Note about MongoDB
echo "⚠️  Note: MongoDB setup will need to be configured manually."
echo "   You can use MongoDB Atlas or add a MongoDB addon later."

# Deploy the app
echo "🚀 Deploying to Heroku..."
git add .
git commit -m "Deploy to Heroku - Updated AI compliance trap"
git push heroku master

# Open the app
echo "🌐 Opening the deployed app..."
heroku open --app $app_name

echo "✅ Deployment complete!"
echo "📊 View logs: heroku logs --tail --app $app_name"
echo "🔧 Manage app: https://dashboard.heroku.com/apps/$app_name"
echo ""
echo "📝 Next steps:"
echo "1. Set up MongoDB connection (MongoDB Atlas recommended)"
echo "2. Update MONGO_URI environment variable"
echo "3. Test the AI compliance trap functionality" 