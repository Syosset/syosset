class CoursesController < ApplicationController

  before_action :get_course, only: [:show, :subscribe, :unsubscribe]
  before_action :get_department, only: [:index]

  def index
    @courses = @department.courses.page params[:page]
    @actions = []
  end

  def show
    actions_builder = ActionsBuilder.new(current_holder)
    actions_builder.require(:edit, @course).add_action("Edit Course", :get, edit_admin_course_path(department_id: @course.department))
    actions_builder.require(:edit, @course).add_action("Manage Collaborators", :get, edit_admin_collaborator_group_path(@course.collaborator_group))
    actions_builder.require(:edit, @course).add_action("Make Announcement", :get, new_admin_announcement_path(course_id: @course.id))
    actions_builder.require(:edit, @course).add_action("Make Link", :get, new_admin_link_path(course_id: @course.id))
    actions_builder.require(:destroy, @course).add_action("Destroy Course", :delete, admin_course_path(@course), data: { confirm: 'Are you sure?' })
    @actions = actions_builder.actions
  end

  def subscribe
    @course.subscribe_user(current_user)
    redirect_to course_path(@course), :notice => 'Successfully subscribed to course.'
  end

  def unsubscribe
    @course.unsubscribe_user(current_user)
    redirect_to course_path(@course), :notice => 'Successfully un-subscribed from course.'
  end

  private
  def get_course
    @course = Course.find(params[:id])
  end

  def get_department
    @department = Department.find(params[:department_id])
  end

end
