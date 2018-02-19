class AdminController < ApplicationController

  def index
    authorize :admin_panel, :view
  end

  def renew
    unless Current.user.super_admin
      redirect_to root_path, alert: 'You must be an administrator to do that.'
    else
      Current.user.renew_admin
      render :json => {admin_until: Current.user.admin_expiry}
    end
  end

  def resign
    Current.user.resign_admin
    render :json => {admin_until: -1}
  end

end
