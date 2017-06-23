# Syosset Web

This is the [official website for Syosset High School](https://syosseths.com/). It is written in Ruby on Rails (version 5) currently under ruby 2.3.4.

In order to get the red-white day display correct:

  * Set the environment variables IC_USERNAME and IC_PASSWORD to your Infinite Campus username and password, respectively.

  * Have phantomjs installed on the system

  * Run clockwork on lib/clock.rb

For sign ins, please set the environment variables `GOOGLE_CLIENT_ID` and `GOOGLE_CLIENT_SECRET` to the credentials provided to you from Google APIs.

The official site is deployed on an EC2 instance running Dokku. To deploy in the same manner, [install Dokku](https://github.com/dokku/dokku), then download and configure:

  *  [dokku-mongo](https://github.com/dokku/dokku-mongo)
  *  [dokku-redis](https://github.com/dokku/dokku-redis)
  *  [dokku-apt](https://github.com/F4-Group/dokku-apt)

After deploying, scale the `clock` process to 1 for clockwork: `dokku ps:scale shs-web clock=1`
