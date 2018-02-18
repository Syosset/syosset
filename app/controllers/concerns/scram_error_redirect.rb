module ScramErrorRedirect
  extend ActiveSupport::Concern

  included do
    rescue_from ScramUtils::NotAuthorizedError do |exception|
      respond_to do |format|
        format.json { head :forbidden }
        format.html do
          unless user_signed_in?
            redirect_to main_app.new_user_session_path, :alert => "You must be signed in to do that."
          else
            redirect_to root_path, :alert => "You do not have permission to do that."
          end
        end
      end
    end
  end
end