module PeekPermissions
  extend ActiveSupport::Concern

  private
    def peek_enabled?
      Rails.env.development? || (user_signed_in? && current_user.super_admin)
    end
end