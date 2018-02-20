SecureHeaders::Configuration.default do |config|
  config.cookies = {
    secure: true, # mark all cookies as "Secure"
    httponly: true, # mark all cookies as "HttpOnly"
    samesite: {
      lax: true # mark all cookies as SameSite=lax
    }
  }
  config.hsts = "max-age=#{6.months.to_i}"
  config.x_frame_options = 'DENY'
  config.x_content_type_options = 'nosniff'
  config.x_xss_protection = '1; mode=block'
  config.x_download_options = 'noopen'
  config.x_permitted_cross_domain_policies = 'none'
  config.referrer_policy = %w[strict-origin-when-cross-origin]
  config.csp = {
    default_src: ['\'none\''],
    base_uri: ['\'self\''],
    block_all_mixed_content: true,
    form_action: ['\'self\''],
    frame_ancestors: ['\'none\''],
    connect_src: ['\'self\'', 'accounts.google.com', 'www.google-analytics.com', 'translate.googleapis.com',
                  'cdn.jsdelivr.net'],
    font_src: ['\'self\'', 'data:'],
    object_src: ['\'none\''],
    img_src: ['\'self\'', 'data:', 'uploads.syosseths.com', 'www.google-analytics.com', 'www.gstatic.com',
              'www.google.com', 'translate.googleapis.com', 'translate.google.com'],
    style_src: ['\'self\'', '\'unsafe-inline\'', 'translate.googleapis.com'],
    script_src: ['\'self\'', '\'unsafe-inline\'', '\'unsafe-eval\'', 'www.google-analytics.com', 'translate.google.com',
                 'translate.googleapis.com'],
    report_uri: [ENV['CSP_REPORT_URI']]
  }
end
