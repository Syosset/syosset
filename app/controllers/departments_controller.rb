class DepartmentsController < ApplicationController
  before_action :get_department, only: [:show, :subscribe, :unsubscribe]

  def index
    @departments = Department.full_text_search(params[:search], allow_empty_search: true).by_priority.page params[:search]

    actions_builder = ActionsBuilder.new(current_holder)
    actions_builder.require(:create, @department).add_action("New Department", :get, new_admin_department_path(@department))
    @actions = actions_builder.actions
  end

  def show
    actions_builder = ActionsBuilder.new(current_holder)
    actions_builder.require(:edit, @department).add_action("Edit Department", :get, edit_admin_department_path(@department))
    actions_builder.require(:edit, @department).add_action("Manage Collaborators", :get, edit_admin_collaborator_group_path(@department.collaborator_group))
    actions_builder.require(:edit, @department).add_action("Make Course", :get, new_admin_department_course_path(department_id: @department.id))
    actions_builder.require(:edit, @department).add_action("Make Announcement", :get, new_admin_announcement_path(department_id: @department.id))
    actions_builder.require(:edit, @department).add_action("Make Link", :get, new_admin_link_path(department_id: @department.id))
    actions_builder.require(:destroy, @department).add_action("Destroy Department", :delete, admin_department_path(@department), data: { confirm: 'Are you sure?' })
    @actions = actions_builder.actions
  end

  def subscribe
    @department.subscribe_user(current_user)
    redirect_to department_path(@department), :notice => 'Successfully subscribed to department.'
  end

  def unsubscribe
    @department.unsubscribe_user(current_user)
    redirect_to department_path(@department), :notice => 'Successfully un-subscribed from department.'
  end

  private
  def get_department
    @department = Department.find(params[:id])
  end


end
