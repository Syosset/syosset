module Admin
  class CoursesController < BaseController
    before_action :get_course, only: [:edit, :update, :destroy]
    before_action :get_department, only: [:create, :new]

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
      authorize @course
    end

    def edit
      authorize @course
    end

    def update
      authorize @course
      @course.update!(course_params)
      redirect_to course_path(@course), flash: {:success => "Course has been updated"}
    end

    def destroy
      authorize @course
      @department = @course.department
      @course.destroy
      redirect_to department_path(@department), flash: {:alert => "Course destroyed"}
    end

    private
    def get_course
      @course = Course.find(params[:id])
    end

    def get_department
      @department = Department.find(params[:department_id])
    end

    def course_params
      params.require(:course).permit!
    end
  end
end
