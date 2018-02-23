module PolicyScoped
  extend ActiveSupport::Concern

  included do
    before_action :set_policy
  end

  private
  def set_policy
    @policy = Scram::Policy.find(params[:policy_id]) if params[:policy_id]
  end
end
