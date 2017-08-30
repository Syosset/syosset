Requirements for Red-White display:

  * Set the environment variables IC_USERNAME and IC_PASSWORD to your Infinite Campus username and password, respectively.

  * Have phantomjs installed on the system

  * Run clockwork on lib/clock.rb

For sign ins, set the environment variables `GOOGLE_CLIENT_ID` and `GOOGLE_CLIENT_SECRET` to the credentials provided from Google APIs.

Dokku plugins used in production:

  *  [dokku-mongo](https://github.com/dokku/dokku-mongo)
  *  [dokku-redis](https://github.com/dokku/dokku-redis)
  *  [dokku-apt](https://github.com/F4-Group/dokku-apt)
  *  [dokku-git-rev](https://github.com/dokku-community/dokku-git-rev)
  *  [dokku-hostname](https://github.com/michaelshobbs/dokku-hostname.git)

After deploying, scale the `clock` process to 1 for clockwork: `dokku ps:scale shs-web clock=1`
