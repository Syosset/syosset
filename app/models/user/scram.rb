class User
  module Scram
    extend ActiveSupport::Concern
    include ::Scram::Holder

    included do
      # Sets up a relation where this user now stores "policy_ids". This is a one-way relationship!
      has_and_belongs_to_many :policies, class_name: "Scram::Policy"
      alias_method :user_policies, :policies # NOTE: This macro remaps the actual mongoid relation to be under the name user_policies, since we override it in User#policies to union in the DEFAULT_POLICIES
      field :super_admin, type: Boolean, default: false

      # Overrides Scram::Holder#policies to union in this user's policies along with those default as default policies
      define_method :policies do
        ::Scram::DEFAULT_POLICIES | self.user_policies
      end

      # Defines the compare value used by Scram in the database. We choose to use ObjectIds.
      define_method :scram_compare_value do
        self.id
      end

      define_method :can? do |*args|
        return true if admin_enabled?
        super(*args)
      end

      define_method :admin_enabled? do
        $redis.get("user:#{self.id}:admin_enabled") == "true"
      end

      define_method :toggle_admin do
        raise "User is not an administrator" unless super_admin
        $redis.set("user:#{self.id}:admin_enabled", !admin_enabled?)
      end
    end

  end
end
