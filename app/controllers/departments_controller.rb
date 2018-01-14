class DepartmentsController < ApplicationController
  before_action :get_department, only: [:show, :edit, :update, :destroy, :subscribe, :unsubscribe]

  def index
    @order_mode = current_user.try(:admin_enabled?)

    @departments = Department.full_text_search(params[:search], allow_empty_search: true).by_priority
    unless @order_mode
      @departments = @departments.page params[:page]
    end

    actions_builder = ActionsBuilder.new(current_holder)
    actions_builder.require(:create, @department).add_action("New Department", :get, new_department_path(@department))
    @actions = actions_builder.actions
  end

  def show
    actions_builder = ActionsBuilder.new(current_holder)
    actions_builder.require(:edit, @department).add_action("Edit Department", :get, edit_department_path(@department))
    actions_builder.require(:edit, @department).add_action("Manage Collaborators", :get, edit_collaborator_group_path(@department.collaborator_group))
    actions_builder.require(:edit, @department).add_action("View Audit Log", :get, history_trackers_path(department_id: @department.id))
    actions_builder.require(:edit, @department).add_action("Make Course", :get, new_department_course_path(department_id: @department.id))
    actions_builder.require(:edit, @department).add_action("Make Announcement", :get, new_announcement_path(department_id: @department.id))
    actions_builder.require(:edit, @department).add_action("Make Link", :get, new_link_path(department_id: @department.id))
    actions_builder.require(:destroy, @department).add_action("Destroy Department", :delete, department_path(@department), data: { confirm: 'Are you sure?' })
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

  def create
    @department = Department.new(department_params)
    authorize @department
    if @department.save
      redirect_to department_path(@department), flash: {:success => "Department has been created"}
    else
      render action: :new
    end
  end

  def new
    authorize Department
    @department = Department.new
  end

  def edit
    authorize @department
  end

  def update
    authorize @department
    if @department.update(department_params)
      redirect_to department_path(@department), flash: {:success => "Department has been updated"}
    else
      render action: 'edit'
    end
  end

  def destroy
    authorize @department
    @department.destroy
    redirect_to departments_path, flash: {:alert => "Department destroyed"}
  end

  private
  def get_department
    @department = Department.find(params[:id])
  end

  def department_params
    params.require(:department).permit(:name, :phone, :short_description, :markdown).merge(modifier: current_user)
  end

end
