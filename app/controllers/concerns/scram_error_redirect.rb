module ScramErrorRedirect
  extend ActiveSupport::Concern

  included do
    rescue_from ScramUtils::NotAuthorizedError do |_exception|
      respond_to do |format|
        format.json { head :forbidden }
        format.html do
          if Current.user
            redirect_to root_path, alert: 'You do not have permission to do that.'
          else
            redirect_to main_app.login_path, alert: 'You must be signed in to do that.'
          end
        end
      end
    end
  end
end
