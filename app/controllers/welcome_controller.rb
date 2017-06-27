class WelcomeController < ApplicationController
  def index
    @announcements = Announcement.escalated.desc(:created_at).limit(8)
  end

  def about
  end
end
