class AnnouncementsController < ApplicationController
  def index
    @announcements = Announcement.all
  end

  def show
    asdf
  end
end
