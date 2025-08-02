#!/bin/bash

echo "🧪 Testing deployment setup..."

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed. Please install Docker first."
    exit 1
fi

# Check if all required files exist
echo "📁 Checking required files..."
required_files=("Dockerfile" "heroku.yml" ".dockerignore" "package.json" "server/package.json" "client/package.json")
for file in "${required_files[@]}"; do
    if [ -f "$file" ]; then
        echo "✅ $file exists"
    else
        echo "❌ $file is missing"
        exit 1
    fi
done

# Test Docker build locally
echo "🐳 Testing Docker build..."
if docker build -t mern-ecommerce-test .; then
    echo "✅ Docker build successful"
else
    echo "❌ Docker build failed"
    exit 1
fi

# Test if the app starts correctly
echo "🚀 Testing app startup..."
docker run --rm -p 3000:3000 -e NODE_ENV=production -e PORT=3000 mern-ecommerce-test &
CONTAINER_ID=$!

# Wait for app to start
sleep 10

# Test if the app is responding
if curl -f http://localhost:3000/api > /dev/null 2>&1; then
    echo "✅ App is responding on port 3000"
else
    echo "❌ App is not responding on port 3000"
    docker stop $CONTAINER_ID
    exit 1
fi

# Clean up
docker stop $CONTAINER_ID
docker rmi mern-ecommerce-test

echo "🎉 All tests passed! Ready for Heroku deployment."
echo ""
echo "Next steps:"
echo "1. Run: ./deploy-heroku.sh"
echo "2. Or follow manual deployment in HEROKU_DEPLOYMENT.md" 