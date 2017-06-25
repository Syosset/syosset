class ApplicationController < ActionController::Base
  include ScramUtils
  protect_from_forgery with: :exception

  before_action :find_alerts

  rescue_from ScramUtils::NotAuthorizedError do |exception|
    respond_to do |format|
      format.json { head :forbidden }
      format.html { redirect_to main_app.new_user_session_path, :alert => "You are not authorized to perform that action at this time. Please try signing in!" }
    end
  end

  protected
  def valid_user
    redirect_to new_user_session_path, :alert => 'You must be signed in to do this.' unless user_signed_in?
  end

  private
  def find_alerts
    if user_signed_in?
      q = current_user.alerts.unread.desc(:updated_at)
      @alerts = q.lazy.select(&:valid?).take(26).to_a

      if @alerts.size <= 25
        @alert_count = @alerts.size
      else
        @alerts = @alerts.take(25)
        @alert_count = q.count
      end
    end
  end
end
