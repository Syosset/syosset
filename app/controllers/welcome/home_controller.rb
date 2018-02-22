class Welcome::HomeController < ApplicationController
  include HomeResources
  def show
    @active_promotions = Rails.cache.fetch('active_promotions', expires_in: 5.minutes) do
      Promotion.where(enabled: true).by_priority
    end
  end
end
