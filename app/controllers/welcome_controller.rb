class WelcomeController < ApplicationController
  def index
    @announcements = Announcement.escalated(8).sort_by!(&:created_at)
  end

  def about
  end
end
