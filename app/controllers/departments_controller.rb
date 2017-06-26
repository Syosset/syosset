class DepartmentsController < ApplicationController
  before_action :get_department, only: [:show]

  def index
    # @departments is set by the application controller (for the navbar listing)
    actions_builder = ActionsBuilder.new(current_holder)
    actions_builder.require(:create, @department).add_action("New Department", :get, new_admin_department_path(@department))
    @actions = actions_builder.actions
  end

  def show
    actions_builder = ActionsBuilder.new(current_holder)
    actions_builder.require(:edit, @department).add_action("Edit Department", :get, edit_admin_department_path(@department))
    actions_builder.require(:edit, @department).add_action("Manage Collaborators", :get, edit_admin_collaborator_group_path(@department.collaborator_group))
    actions_builder.require(:destroy, @department).add_action("Destroy Department", :delete, admin_department_path(@department), data: { confirm: 'Are you sure?' })
    @actions = actions_builder.actions
  end

  private
  def get_department
    @department = Department.find(params[:id])
  end


end
