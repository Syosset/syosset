class PeriodsController < ApplicationController
  before_action :get_user
  before_action :check_staff, except: [:index]
  before_action :get_period, only: [:edit, :update, :destroy]
  before_action :get_user_courses, only: [:new, :edit]

  def index
    redirect_to root_path, alert: 'Only students may view schedules.' unless Current.user

    unless @user.staff?
      redirect_back fallback_location: root_path, alert: 'Only staff can have schedules.'
    else
      @periods = @user.periods.asc(:period)
    end
  end

  def new
    authorize @user, :edit
    @period = Period.new
  end

  def create
    authorize @user, :edit
    @period = Period.new(period_params)
    @period.user = @user
    @period.save
    redirect_to user_periods_path(@user)
  end

  def edit
    authorize @user, :edit
  end

  def update
    authorize @user, :edit
    @period.update!(period_params)
    redirect_to user_periods_path(@user)
  end

  def destroy
    authorize @user, :edit
    @period.destroy!
    redirect_to user_periods_path(@period.user), alert: 'The period has been removed successfully.'
  end

  private
    def check_staff
      redirect_back fallback_location: root_path, alert: 'Only staff can have schedules.' unless Current.user.staff?
    end

    def get_user
      @user = User.find(params[:user_id])
    end

    def period_params
      pp = params.require(:period).permit(:period, :course, :room)
      pp[:course] = Course.find(pp[:course]) unless pp[:course].nil?

      pp
    end

    def get_period
      @period = Period.find(params[:id])
    end

    def get_user_courses
      @courses = CollaboratorGroup.with_member(@user).select { |x| x.collaboratable.is_a? Course }.map(&:collaboratable)
    end
end
