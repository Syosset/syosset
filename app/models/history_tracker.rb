class HistoryTracker
  include Mongoid::History::Tracker

  before_save :set_modifier
  before_update :set_modifier

  protected
  def set_modifier
    self.modifier = Current.user
  end
end
