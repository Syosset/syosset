class CoursesController < ApplicationController

  before_action :get_course, only: [:show, :subscribe, :unsubscribe, :edit, :update, :destroy]
  before_action :get_department, only: [:index, :create, :new]

  def index
    @courses = @department.courses.full_text_search(params[:search], allow_empty_search: true).page params[:page]
    @actions = []
  end

  def show
    actions_builder = ActionsBuilder.new(current_holder)

    actions_builder.require(:edit, @course)
      .add_action("Edit Course", :get, edit_course_path(department_id: @course.department))

    actions_builder.require(:edit, @course)
      .add_action("Manage Collaborators", :get, edit_collaborator_group_path(@course.collaborator_group))

    actions_builder.require(:edit, @course)
      .add_action("View Audit Log", :get, history_trackers_path(course_id: @course.id))

    actions_builder.require(:edit, @course)
      .add_action("Make Announcement", :get, new_announcement_path(course_id: @course.id))

    actions_builder.require(:edit, @course)
      .add_action("Make Link", :get, new_link_path(course_id: @course.id))

    actions_builder.require(:destroy, @course)
      .add_action("Destroy Course", :delete, course_path(@course), data: { confirm: 'Are you sure?' })

    @actions = actions_builder.actions
  end

  def subscribe
    @course.subscribe_user(Current.user)
    redirect_to course_path(@course), :notice => 'Successfully subscribed to course.'
  end

  def unsubscribe
    @course.unsubscribe_user(Current.user)
    redirect_to course_path(@course), :notice => 'Successfully un-subscribed from course.'
  end

  def create
    @course = Course.new(course_params)
    @course.department = @department
    authorize @course

    if @course.save
        redirect_to course_path(@course), flash: {:success => "Course has been created"}
    else
        render action: 'new'
    end
  end

  def new
    @course = Course.new
  end

  def edit
    authorize @course
  end

  def update
    authorize @course
    if @course.update(course_params)
      redirect_to course_path(@course), flash: {:success => "Course has been updated"}
    else
      render action: 'edit'
    end
  end

  def destroy
    authorize @course
    @department = @course.department
    @course.destroy
    redirect_to department_path(@department), flash: {:alert => "Course destroyed"}
  end

  private
  def get_course
    @course = Course.includes(:announcements, :links).find(params[:id])
  end

  def get_department
    @department = Department.find(params[:department_id])
  end

  def course_params
    params.require(:course).permit(:name, :course_id, :short_description, :markdown).merge(modifier: Current.user)
  end

end
