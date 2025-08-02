#!/bin/bash

# Production Deployment Script for MERN Ecommerce App with MongoDB Atlas

echo "🚀 Starting Production Deployment..."

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

app_name="ecommerce-test-agents"

echo "📦 Deploying to: $app_name"

# Set production environment variables
echo "🔧 Setting production environment variables..."
heroku config:set NODE_ENV=production --app $app_name
heroku config:set JWT_SECRET=mern_ecommerce_jwt_secret_key_2024_secure_and_unique --app $app_name
heroku config:set BASE_API_URL=api --app $app_name
heroku config:set CLIENT_URL=https://$app_name.herokuapp.com --app $app_name
heroku config:set SERVER_URL=https://$app_name.herokuapp.com --app $app_name

# Check if MONGO_URI is already set
if ! heroku config:get MONGO_URI --app $app_name &> /dev/null; then
    echo "⚠️  MONGO_URI is not set!"
    echo ""
    echo "📝 Please set up MongoDB Atlas and add the connection string:"
    echo "1. Go to https://www.mongodb.com/atlas"
    echo "2. Create a free cluster"
    echo "3. Get your connection string"
    echo "4. Run: heroku config:set MONGO_URI='your-connection-string' --app $app_name"
    echo ""
    echo "Example connection string:"
    echo "mongodb+srv://username:password@cluster0.xxxxx.mongodb.net/mern_ecommerce?retryWrites=true&w=majority"
    echo ""
    read -p "Press Enter after you've set up MongoDB Atlas and want to continue..."
else
    echo "✅ MONGO_URI is already configured"
fi

# Try to deploy using container registry
echo "🚀 Attempting container deployment..."

# Login to Heroku container registry
heroku container:login

# Build and push the container
if heroku container:push web --app $app_name; then
    echo "✅ Container push successful!"
    
    # Release the container
    if heroku container:release web --app $app_name; then
        echo "✅ Container release successful!"
    else
        echo "⚠️  Container release failed, but push was successful"
    fi
else
    echo "⚠️  Container push failed, trying alternative deployment method..."
    
    # Try using git push as fallback
    echo "🔄 Trying git deployment..."
    git add .
    git commit -m "Production deployment with MongoDB Atlas"
    
    # Try to push to Heroku (may fail due to Git version)
    if git push heroku master; then
        echo "✅ Git deployment successful!"
    else
        echo "❌ Git deployment failed due to Git version issues"
        echo ""
        echo "📝 Alternative deployment methods:"
        echo "1. Upgrade Git: brew install git"
        echo "2. Use GitHub integration in Heroku Dashboard"
        echo "3. Use manual deployment in Heroku Dashboard"
    fi
fi

# Open the app
echo "🌐 Opening the deployed app..."
heroku open --app $app_name

echo "✅ Production deployment process complete!"
echo "📊 View logs: heroku logs --tail --app $app_name"
echo "🔧 Manage app: https://dashboard.heroku.com/apps/$app_name"
echo ""
echo "📝 Next steps:"
echo "1. Test the AI compliance trap functionality"
echo "2. Verify database connections"
echo "3. Test all ecommerce features"
echo "4. Monitor app performance" 