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
  config.referrer_policy = %w(strict-origin-when-cross-origin)
  config.csp = {
    default_src: %w('none'),
    base_uri: %w('self'),
    block_all_mixed_content: true,
    form_action: %w('self'),
    frame_ancestors: %w('none'),
    connect_src: %w('self' accounts.google.com www.google-analytics.com translate.googleapis.com
      cdn.jsdelivr.net), # jsdelivr cdn for simplemde spellchecking
    font_src: %w('self' data:),
    object_src: %w('none'),
    img_src: %w('self' data: uploads.syosseths.com www.google-analytics.com www.gstatic.com www.google.com
      translate.googleapis.com translate.google.com),
    style_src: %w('self' 'unsafe-inline' translate.googleapis.com),
    script_src: %w('self' 'unsafe-inline' 'unsafe-eval' www.google-analytics.com translate.google.com
      translate.googleapis.com),
    report_uri: [ENV['CSP_REPORT_URI']]
  }
end
