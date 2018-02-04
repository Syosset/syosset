## Deployment with Dokku
Our production deployment (syosseths.com) is deployed and managed using [Dokku](https://github.com/dokku/dokku/). For this to work, a few plugins are required:
  - [dokku-mongo](https://github.com/dokku/dokku-mongo), providing a MongoDB service
  - [dokku-redis](https://github.com/dokku/dokku-redis), providing a Redis service
  - [dokku-apt](https://github.com/F4-Group/dokku-apt), to install packages required for browser emulation and image resizing
  - [dokku-git-rev](https://github.com/dokku-community/dokku-git-rev), to report app version to Sentry + Peek
  - [dokku-hostname](https://github.com/michaelshobbs/dokku-hostname.git), to display the app host in Peek

## Deployment with Heroku
Our review (syosset-staging-pr-xxx.herokuapp.com) and staging (staging.syosseths.com) environments are hosted on [Heroku](https://heroku.com). Out of the box, the app should configure and run itself, but you may wish to add the [imagemagick buildpack](https://github.com/jacobsmith/heroku-buildpack-imagemagick) and [phantomjs buildpack](https://github.com/stomita/heroku-buildpack-phantomjs) on the Heroku dashboard to allow the app to resize uploaded images and fetch day color state from Infinite Campus.

## Configuration
Although the app is deployable to Heroku out of the box, certain functionality will be disabled without these environment variables set:
  - For users to sign in via oauth, you must provide Google API credentials with access to the Contacts and Google+ API: `GOOGLE_CLIENT_ID` and `GOOGLE_CLIENT_SECRET`
  - To allow the uploading of files, AWS credentials with write access to an S3 bucket must be provided: `S3_BUCKET_NAME`, `AWS_REGION`, `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`
  - To serve user content from a CDN pointing to the S3 bucket, you can provide a URL: `CDN_URL`
  - To fetch day color information from Infinite Campus, you must provide a username/password combination: `IC_USERNAME` and `IC_PASSWORD`
  - To report application errors to Sentry: `SENTRY_DSN`
  - To report Content Security Policy violations, you can set a report URI: `CSP_REPORT_URI`
  - To automatically generate alt tags for images, you must have credentials for Azure Cognitive Services: `AZURE_REGION` and `AZURE_COGNITIVE_SERVICES_KEY`

## Development Environment
In development and test environments, you can set all environment variables via a `.env` file in the project's root directory:
```
GOOGLE_CLIENT_ID=xxxxxx-xxxxxxxxxxxx.apps.googleusercontent.com
GOOGLE_CLIENT_SECRET=xxxxxxxxx

S3_BUCKET_NAME=shs-uploads
AWS_ACCESS_KEY_ID=XXXXXX
AWS_SECRET_ACCESS_KEY=XXXXXXXXXXXX
AWS_REGION=us-east-2
CDN_URL=uploads.syosseths.com

IC_USERNAME=xxxxxx
IC_PASSWORD=xxxxxxxxxxxx

SENTRY_DSN=https://xxxxxx:xxxxxxxxx@sentry.io/xxxxxx
CSP_REPORT_URI=https://sentry.io/api/xxxxxx/csp-report/?sentry_key=xxxxxxxxx

AZURE_REGION=eastus
AZURE_COGNITIVE_SERVICES_KEY=xxxxxxxxxxxx
```