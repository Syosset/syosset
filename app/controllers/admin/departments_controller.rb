module Admin
  class DepartmentsController < BaseController
    before_action :get_department, only: [:edit, :update, :destroy]

    def create
      @department = Department.new(department_params)
      authorize @department

      @department.save!
      redirect_to department_path(@department), flash: {:success => "Department has been created"}
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
      params.require(:department).permit!
    end
  end
end
