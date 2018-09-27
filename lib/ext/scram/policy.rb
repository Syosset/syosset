module Ext
  module Scram
    module Policy
      def self.included(base)
        base.class_eval do
          has_many :policy_holders, class_name: 'Scram::PolicyHolder'
          define_method :holders do
            policy_holders.map(&:holder)
          end
        end
      end
    end
  end
end
Scram::Policy.include(Ext::Scram::Policy)
