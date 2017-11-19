module Admin
  class BaseController < ApplicationController

    before_action :authenticate_user!, only: [:toggle]
    
    def index
      authorize :admin_panel, :view
    end

    def renew
      unless current_user.super_admin
        redirect_to root_path, alert: 'You must be an administrator to do that.'
      else
        current_user.renew_admin
        render :json => {admin_until: current_user.admin_expiry}
      end
    end

    def resign
      current_user.resign_admin
      render :json => {admin_until: -1}
    end

  end
end
