class Welcome::LandingController < ApplicationController
  include HomeResources
  def show
    expires_in 5.minutes, public: true unless Current.user
  end
end
