class ApplicationController < ActionController::Base
  include ScramUtils
  helper_method :current_holder

  protect_from_forgery with: :exception

  before_action :find_alerts
  before_action :set_navbar_resources
  before_action :get_revision

  rescue_from ScramUtils::NotAuthorizedError do |exception|
    respond_to do |format|
      format.json { head :forbidden }
      format.html { redirect_to main_app.new_user_session_path, :alert => "You are not authorized to perform that action at this time. Please try signing in!" }
    end
  end

  def notify_integrations(message)
    Integration.each {|i| i.create_provider.notify(message)}
  end

  rescue_from ActionController::RoutingError, :with => :not_found
  rescue_from Mongoid::Errors::DocumentNotFound, :with => :not_found

  def not_found
    redirect_to root_path, :alert => "The page you requested does not exist."
  end

  def peek_enabled?
    Rails.env.development? || (user_signed_in? && current_user.super_admin)
  end

  def autocomplete
    if params[:term]
      @users = User.any_of({name: /.*#{params[:term]}.*/i}, {email: /.*#{params[:term]}.*/i}).limit(5)
    else
      @users = User.all
    end

    respond_to do |format|
      format.json { render :json => @users.map{|u| {value: u.id.to_s, label: u.name, desc: u.email} }.to_json }
      end
  end

  protected
  def valid_user
    redirect_to new_user_session_path, :alert => 'You must be signed in to do this.' unless user_signed_in?
  end

  private
  def get_revision
    if defined? $g
      i = 0
      while $g.log[i].message =~ /\[HIDE\]/i or $g.log[i].message =~ /Merge ?:(pull request|branch) #(.*)/
        i += 1
      end
      @revision = $g.log[i].sha
    else
      @revision = ENV['GIT_SHA'] || "???"
    end
  end

  def set_navbar_resources
    @departments = Department.by_priority # TODO cache
  end

  def find_alerts
    if user_signed_in?
      q = current_user.alerts.unread.desc(:updated_at)
      @alerts = q.lazy.select(&:valid?).take(26).to_a

      if @alerts.size <= 25
        @alert_count = @alerts.size
      else
        @alerts = @alerts.take(25)
        @alert_count = q.count
      end
    end
  end
end
