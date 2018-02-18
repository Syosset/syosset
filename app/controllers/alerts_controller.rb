class AlertsController < ApplicationController
  before_action :ensure_signed_in

  def index
    @all_alerts = Alert.user(current_user).desc(:updated_at)
    # TODO: pagination, index view for all alerts
  end

  def show
    alert = Alert.where(id: params[:id]).user(current_user).one
    alert.mark_read!

    if alert.link
      redirect_to alert.link
    else
      redirect_back
    end
  end

  def read_all
    Alert.user(current_user).mark_read!
    redirect_to alerts_path, alert: "Marked all alerts as read"
  end

  private
    def ensure_signed_in
      redirect_to new_user_session_path, :alert => 'You must be signed in to do this.' unless user_signed_in?
    end
end
