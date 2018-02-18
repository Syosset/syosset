class WelcomeController < ApplicationController
  before_action :get_information, only: [:index, :landing]

  def index
  end

  def about
  end

  def landing
    unless user_signed_in?
      expires_in 5.minutes, public: true
    end
  end

  def status
    render json: {ok: true}
  end

  private
  def get_information
    @announcements = Rails.cache.fetch("announcements", expires_in: 5.minutes) do
      # First 8 escalated announcements, padded with latest if there are less than 8
      (Announcement.escalated(8).sort_by!(&:created_at).reverse + Announcement.desc(:created_at).limit(8).to_a)
        .first(8).uniq
    end
    @links = Rails.cache.fetch("links", expires_in: 5.minutes) do
      Link.escalated(5).sort_by!(&:created_at)
    end
  end
end
