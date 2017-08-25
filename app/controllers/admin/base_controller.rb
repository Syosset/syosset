module Admin
  class BaseController < ApplicationController

    before_action :authenticate_user!, only: [:toggle]
    
    def index
      authorize :admin_panel, :view
    end

    def toggle
      unless current_user.super_admin
        redirect_to root_path, alert: 'You must be an administrator to do that.'
      else
        current_user.toggle_admin
        redirect_to root_path
      end
    end

  end
end
