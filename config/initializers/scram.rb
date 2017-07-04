module Scram::Holder
  def cannot?(*args)
    !can?(*args)
  end
end

module Scram
  DEFAULT_POLICIES = []
  if Rails.env.test?
    test_policy = Policy.new(name: "Test Policy")
    test_policy.targets.build(
      conditions: {:equals => {:'*target_name' => "boing"}},
      actions: ["create", "edit", "destroy"]
    )
    DEFAULT_POLICIES << test_policy
  end

  def add_collaborator_policy(model, actions=["edit"])

  end

  collaborator_policy = ->(model, actions=["edit"]) {
    policy = Policy.new(name: "#{model.to_s.humanize} Collaborator", context: model.to_s)
    policy.targets.build(conditions: { :includes => { :'*collaborators' =>  "*holder"  } }, actions: actions)
    return policy
  }

  DEFAULT_POLICIES << collaborator_policy.(Department)
  DEFAULT_POLICIES << collaborator_policy.(Announcement)
  DEFAULT_POLICIES << collaborator_policy.(Link)

  DEFAULT_POLICIES.freeze

  # Class to be a holder with the DEFAULT_POLICIES when a User is not available.
  class DefaultHolder
    include Holder

    attr_accessor :policies

    def initialize()
      @policies = DEFAULT_POLICIES
    end

    # This is likely never to be used, since it wouldn't make sense to store permissions that only logged out users can perform
    def scram_compare_value
      "default-holder"
    end
  end

  # Defines the DefaultHolder as a constant once, to prevent recreating it incessantly.
  DEFAULT_HOLDER ||= DefaultHolder.new
  DEFAULT_HOLDER.freeze
end
