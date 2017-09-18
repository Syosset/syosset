class PeriodsController < ApplicationController

  before_action :check_staff, except: [:index]
  before_action :get_period, only: [:edit, :update, :destroy]
  before_action :get_user_courses, only: [:new, :edit]

  def index
    @user = User.find(params[:user_id])
    unless @user.staff?
      redirect_back fallback_location: root_path, alert: "Only staff can have schedules."
    else
      @periods = @user.periods.asc(:period)
    end
  end

  def new
    authorize current_user, :edit
    @period = Period.new
  end

  def create
    authorize current_user, :edit
    @period = Period.new(period_params)
    @period.user = current_user
    @period.save
    redirect_to user_periods_path(current_user)
  end

  def edit
    authorize current_user, :edit
  end

  def update
    authorize current_user, :edit
    @period.update!(period_params)
    redirect_to user_periods_path(current_user)
  end

  def destroy
    authorize current_user, :edit
    @period.destroy!
    redirect_to user_path(@period.user), alert: "The period has been removed successfully."
  end

  private
    def check_staff
      unless current_user.staff?
        redirect_back fallback_location: root_path, alert: "Only staff can have schedules."
      end
    end

    def period_params
      pp = params.require(:period).permit(:period, :course, :room)
      unless pp[:course].nil?
        pp[:course] = Course.find(pp[:course])
      end
      pp
    end

    def get_period
      @period = Period.find(params[:id])
    end

    def get_user_courses
      @courses = CollaboratorGroup.with_member(current_user).select {|x| x.collaboratable.is_a? Course }.map(&:collaboratable)
    end


end
