# Heroku Deployment Guide for MERN Ecommerce App

This guide will help you deploy the MERN ecommerce application to Heroku using Docker containers.

## Prerequisites

1. **Heroku CLI**: Install from [https://devcenter.heroku.com/articles/heroku-cli](https://devcenter.heroku.com/articles/heroku-cli)
2. **Git**: Ensure your project is in a Git repository
3. **Heroku Account**: Sign up at [https://heroku.com](https://heroku.com)

## Quick Deployment

### Option 1: Automated Script (Recommended)

```bash
# Make sure you're in the ecommerce directory
cd ecommerce

# Run the deployment script
./deploy-heroku.sh

# Or specify an app name
./deploy-heroku.sh your-app-name
```

### Option 2: Manual Deployment

```bash
# 1. Login to Heroku
heroku login

# 2. Create a new Heroku app
heroku create your-app-name

# 3. Set the stack to container
heroku stack:set container

# 4. Add MongoDB addon
heroku addons:create mongolab:sandbox

# 5. Set environment variables
heroku config:set NODE_ENV=production
heroku config:set JWT_SECRET=your_jwt_secret_here
heroku config:set BASE_API_URL=api
heroku config:set CLIENT_URL=https://your-app-name.herokuapp.com
heroku config:set SERVER_URL=https://your-app-name.herokuapp.com

# 6. Deploy
git add .
git commit -m "Deploy to Heroku"
git push heroku main

# 7. Open the app
heroku open
```

## Environment Variables

Set these environment variables in your Heroku app:

```bash
NODE_ENV=production
JWT_SECRET=your_secure_jwt_secret
BASE_API_URL=api
CLIENT_URL=https://your-app-name.herokuapp.com
SERVER_URL=https://your-app-name.herokuapp.com
MONGO_URI=your_mongodb_connection_string
```

## Database Setup

### Option 1: Heroku MongoDB Addon (Free Tier)
```bash
heroku addons:create mongolab:sandbox
```

### Option 2: MongoDB Atlas (Recommended for Production)
1. Create a free cluster at [MongoDB Atlas](https://www.mongodb.com/atlas)
2. Get your connection string
3. Set the environment variable:
```bash
heroku config:set MONGO_URI=your_mongodb_atlas_connection_string
```

## File Structure for Heroku

The deployment uses these key files:

- `Dockerfile` - Main container configuration
- `heroku.yml` - Heroku container configuration
- `.dockerignore` - Files to exclude from Docker build
- `deploy-heroku.sh` - Automated deployment script

## Troubleshooting

### Common Issues

1. **Build Fails**: Check the logs with `heroku logs --tail`
2. **Database Connection**: Ensure MONGO_URI is set correctly
3. **Port Issues**: The app uses port 3000 by default
4. **Environment Variables**: Verify all required variables are set

### Useful Commands

```bash
# View logs
heroku logs --tail

# Check app status
heroku ps

# Restart the app
heroku restart

# Open the app
heroku open

# Check environment variables
heroku config

# Access the app console
heroku run bash
```

## Production Considerations

1. **Security**: Change default JWT_SECRET
2. **Database**: Use MongoDB Atlas for production
3. **SSL**: Heroku provides SSL certificates automatically
4. **Scaling**: Upgrade to paid dynos for better performance
5. **Monitoring**: Set up logging and monitoring

## Support

If you encounter issues:

1. Check the Heroku logs: `heroku logs --tail`
2. Verify environment variables: `heroku config`
3. Ensure all dependencies are in package.json
4. Check the Docker build locally first

## Next Steps

After successful deployment:

1. Test all functionality
2. Set up custom domain (optional)
3. Configure monitoring and alerts
4. Set up CI/CD pipeline
5. Implement backup strategies 