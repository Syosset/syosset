Requirements for Red-White display:

  * Set the environment variables IC_USERNAME and IC_PASSWORD to your Infinite Campus username and password, respectively.

  * Have phantomjs installed on the system

  * Run clockwork on lib/clock.rb

For sign ins, set the environment variables `GOOGLE_CLIENT_ID` and `GOOGLE_CLIENT_SECRET` to the credentials provided from Google APIs.

For file uploads, AWS credentials with s3:PutObject and s3:PutObjectAcl permissions to an S3 bucket are required. They can be configured
via the following environment variables:
```
S3_BUCKET_NAME=<s3 bucket name>
AWS_REGION=<s3 bucket region>
AWS_ACCESS_KEY_ID=<aws access key id>
AWS_SECRET_ACCESS_KEY=<aws secret access key>
```

Dokku plugins used in production:

  *  [dokku-mongo](https://github.com/dokku/dokku-mongo)
  *  [dokku-redis](https://github.com/dokku/dokku-redis)
  *  [dokku-apt](https://github.com/F4-Group/dokku-apt)
  *  [dokku-git-rev](https://github.com/dokku-community/dokku-git-rev)
  *  [dokku-hostname](https://github.com/michaelshobbs/dokku-hostname.git)

After deploying, scale the `clock` process to 1 for clockwork: `dokku ps:scale shs-web clock=1`
