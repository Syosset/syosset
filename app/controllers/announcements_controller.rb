class AnnouncementsController < ApplicationController

  before_action :get_announcement, except: [:index]

  def index
    @announcements = Announcement.all
  end

  def show
  end

  private
  def get_announcement
    @announcement = Announcement.find(params[:id])
  end
end
