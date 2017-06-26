class DepartmentsController < ApplicationController
  before_action :get_department, only: [:show]

  def index
    # @departments is set by the application controller (for the navbar listing)
  end

  def show
  end

  private
  def get_department
    @department = Department.find(params[:id])
  end


end
