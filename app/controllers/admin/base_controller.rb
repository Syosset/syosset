module Admin
  class BaseController < ::ApplicationController
    def index
      redirect_to new_user_session_path
    end
  end
end
