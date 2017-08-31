class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    redirect_to root_path, alert: "Only staff members can have profiles." unless @user.staff?
    @periods = @user.periods.asc(:period)
  end
end
