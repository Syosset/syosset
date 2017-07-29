class CoursesController < ApplicationController

  before_action :get_course, only: [:show]
  before_action :get_department, only: [:index]

  def index
    @courses = @department.courses
    @actions = []
  end

  def show
    @actions = []
  end

  private
  def get_course
    @course = Course.find(params[:id])
  end

  def get_department
      @department = Department.find(params[:department_id])
  end

end
