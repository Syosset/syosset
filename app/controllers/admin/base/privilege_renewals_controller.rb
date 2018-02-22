module Admin
  class Base::PrivilegeRenewalsController < ApplicationController
    def create
      if Current.user.super_admin
        Current.user.renew_admin
        render json: { admin_until: Current.user.admin_expiry }
      else
        redirect_to root_path, alert: 'You must be an administrator to do that.'
      end
    end
  end
end
