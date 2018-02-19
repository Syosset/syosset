class AdminController < ApplicationController
  def index
    authorize :admin_panel, :view
  end

  def renew
    if Current.user.super_admin
      Current.user.renew_admin
      render json: { admin_until: Current.user.admin_expiry }
    else
      redirect_to root_path, alert: 'You must be an administrator to do that.'
    end
  end

  def resign
    Current.user.resign_admin
    render json: { admin_until: -1 }
  end
end
