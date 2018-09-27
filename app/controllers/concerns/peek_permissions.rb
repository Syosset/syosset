# Ensures that the peek bar is only visible in the correct environments
module PeekPermissions
  extend ActiveSupport::Concern

  private

  def peek_enabled?
    Rails.env.development? || Current.user&.super_admin
  end
end
