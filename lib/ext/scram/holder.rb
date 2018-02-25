module Ext
  module Scram
    module Holder
      def self.included(base)
        base.class_eval do
          define_method :cannot? do |*args|
            !can?(*args)
          end
        end
      end
    end
  end
end
Scram::Holder.include(Ext::Scram::Holder)
