# Fetches and caches resources required by all pages on the site
module CachedResources
  extend ActiveSupport::Concern

  included do
    before_action :set_cached_resources
  end

  private

  def set_cached_resources
    @current_day = Day.today
    @active_closure = Rails.cache.fetch('nav_closure', expires_in: 5.minutes) do
      Closure.active_closure
    end
    @departments_summary = Rails.cache.fetch('nav_departments', expires_in: 5.minutes) do
      Department.by_priority.limit(6)
    end
  end
end
