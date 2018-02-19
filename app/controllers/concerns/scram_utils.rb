module ScramUtils
  extend ActiveSupport::Concern

  included do
    helper_method :current_holder
  end

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
        'new' => 'create',
        'update' => 'edit'
      }
      action = automap[action] if automap[action]

      raise NotAuthorizedError, action: action, object: object unless holder.can?(action, object)

      object
    end
  end

  def current_holder
    if params['token']
      holder = Token.where(key: params['token']).first.user
    else
      holder = Current.user ? Current.user : Scram::DEFAULT_HOLDER
    end

    return holder
  end

  def authorize(object, action = nil)
    action ||= params[:action].to_s
    return ScramUtils.authorize(current_holder, action, object)
  end
end
