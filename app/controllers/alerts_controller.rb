class AlertsController < ApplicationController
    before_action :valid_user

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
            redirect_to_back
        end
    end

    def read_all
        Alert.user(current_user).mark_read!
        redirect_to_back alerts_path, alert: "Marked all alerts as read"
    end
end
