module ScramUtils
  extend ActiveSupport::Concern

  class Error < StandardError; end
  class NotAuthorizedError < Error
    attr_reader :query, :record, :policy

    def initialize(options = {})
      if options.is_a? String
        message = options
      else
        @action = options[:action]
        @object = options[:object]

        message = options.fetch(:message) { "not allowed to #{@action} this #{@object.inspect}" }
      end

      super(message)
    end
  end

  class << self
    def authorize(holder, action, object)
      # clusters: (new, create), (edit, update)
      automap = {
        "new" => "create",
        "update" => "edit"
      }
      action = automap[action] if automap[action]
      unless holder.can?(action, object)
        raise NotAuthorizedError, action: action, object: object
      end

      object
    end
  end

  def authorize(object, action = nil)
    action ||= params[:action].to_s
    holder = user_signed_in? ? current_user : Scram::DEFAULT_HOLDER
    return ScramUtils.authorize(holder, action, object)
  end

  def current_holder
    user_signed_in? ? current_user : Scram::DEFAULT_HOLDER
  end
end
