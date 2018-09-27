# Provides request context to Raven to be used in error reports
module RavenContext
  extend ActiveSupport::Concern

  included do
    before_action :set_raven_context
  end

  private

  def set_raven_context
    if Current.user
      Raven.user_context(
        id: Current.user.id.to_s,
        email: Current.user.email,
        name: Current.user.name
      )
    end

    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end
