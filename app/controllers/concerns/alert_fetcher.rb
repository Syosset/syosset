module AlertFetcher
  extend ActiveSupport::Concern

  included do
    before_action :fetch_alerts
  end

  private
    def fetch_alerts
      if user_signed_in?
        q = current_user.alerts.unread.desc(:updated_at)
        @alerts = q.lazy.select(&:valid?).take(26).to_a

        if @alerts.size <= 25
          @alert_count = @alerts.size
        else
          @alerts = @alerts.take(25)
          @alert_count = q.count
        end
      end
    end
end