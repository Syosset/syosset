class ApplicationController < ActionController::Base
  include RequestAuthorization
  include RavenContext
  include NotFoundRedirect
  include CachedResources
  include MarkdownRenderer
  include PeekPermissions
  include AlertFetcher

  include ScramUtils
  include ScramErrorRedirect

  protect_from_forgery with: :exception

end