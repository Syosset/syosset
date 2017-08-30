# Base Presenter class, used for creating Presenters to
# add view-specific / presentation-specific logic to models.
class BasePresenter
  include Rails.application.routes.url_helpers
  attr_reader :model

  delegate :current_holder, to: :h
  delegate :current_user, to: :h
  delegate_missing_to :@model

  def initialize(model, helpers = nil)
    @model = model
    @helpers = helpers
  end

  def h
    @helpers ||= ActionController::Base.helpers
  end

end
