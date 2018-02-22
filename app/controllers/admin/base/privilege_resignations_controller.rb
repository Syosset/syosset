module Admin
  class Base::PrivilegeResignationsController < ApplicationController
    def create
      Current.user.resign_admin
      render json: { admin_until: -1 }
    end
  end
end
