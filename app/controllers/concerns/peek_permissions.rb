module PeekPermissions
  extend ActiveSupport::Concern

  private

  def peek_enabled?
    Rails.env.development? || (Current.user && Current.user.super_admin)
  end
end