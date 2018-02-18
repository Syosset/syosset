module RavenContext
  extend ActiveSupport::Concern

  included do
    before_action :set_raven_context
  end

  private
    def set_raven_context
      if current_user
        Raven.user_context(
          id: current_user.id.to_s,
          email: current_user.email,
          name: current_user.name
        )
      end

      Raven.extra_context(params: params.to_unsafe_h, url: request.url)
    end
end