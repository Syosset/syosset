# Fetches and caches resources used by the home and landing pages
module HomeResources
  extend ActiveSupport::Concern

  included do
    before_action :set_home_resources
  end

  private

  def set_home_resources
    @announcements = Rails.cache.fetch('announcements', expires_in: 5.minutes) do
      # First 8 escalated announcements, padded with latest if there are less than 8
      (Announcement.escalated(8).sort_by!(&:created_at).reverse + Announcement.desc(:created_at).limit(8).to_a)
        .first(8).uniq
    end
    @links = Rails.cache.fetch('links', expires_in: 5.minutes) do
      Link.escalated(8).sort_by!(&:created_at)
    end
  end
end
