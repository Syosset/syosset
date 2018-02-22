class AdministrationsController < ApplicationController
  def show
    authorize :admin_panel, :view
  end
end
