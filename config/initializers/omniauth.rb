Rails.application.config.middleware.use OmniAuth::Builder do

  provider :developer if Rails.env.development? or Rails.env.testing?

  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'],
    {hd: %w(syosset.k12.ny.us kmp.pw johari.tech), skip_jwt: true}

end