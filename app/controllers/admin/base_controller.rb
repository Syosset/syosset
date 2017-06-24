module Admin
  class BaseController < ApplicationController
    before_action :check_admin

    def index
    end

    private
    def check_admin
      authorize :admin_panel, :view
    end
  end
end
