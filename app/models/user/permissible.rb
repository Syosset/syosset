module User::Permissible
  extend ActiveSupport::Concern
  include ::Scram::Holder
  include ::Scram::PolicyHoldable

  included do
    field :super_admin, type: Boolean, default: false

    # Defines the compare value used by Scram in the database. We choose to use ObjectIds.
    define_method :scram_compare_value do
      id
    end

    define_method :can? do |*args|
      return true if admin_enabled?
      super(*args)
    end

    define_method :admin_enabled? do
      expiry = admin_expiry
      expiry.nil? ? false : expiry > Time.now.to_i
    end

    define_method :admin_expiry do
      Redis.current.get("user:#{id}:admin_until")&.to_i
    end

    define_method :renew_admin do
      raise 'User is not an administrator' unless super_admin
      Redis.current.set("user:#{id}:admin_until", (Rails.env.development? ? 30 : 15).minutes.from_now.to_i)
    end

    define_method :resign_admin do
      Redis.current.del("user:#{id}:admin_until")
    end
  end
end
