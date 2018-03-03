class AdministrationsController < ApplicationController
  def show
    authorize :admin_panel
  end
end
