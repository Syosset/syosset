# Fetches alerts for the current user, if any
module AlertFetcher
  extend ActiveSupport::Concern

  included do
    before_action :fetch_alerts
  end

  private

  def fetch_alerts
    return unless Current.user

    q = Current.user.alerts.unread.desc(:updated_at)
    @alerts = q.lazy.select(&:valid?).take(26).to_a

    if @alerts.size <= 25
      @alert_count = @alerts.size
    else
      @alerts = @alerts.take(25)
      @alert_count = q.count
    end
  end
end