module Admin
  class BaseController < ApplicationController
    def index
      authorize :admin_panel, :view
    end
  end
end
