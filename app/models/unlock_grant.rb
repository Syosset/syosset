class UnlockGrant
  include Mongoid::Document
  include Mongoid::Timestamps

  index({expire_at: 1}, {expire_after_seconds: 0})

  belongs_to :student_editable, polymorphic: true
  belongs_to :granter, class_name: "User"

  field :expire_at, type: Time, default: ->{ Time.now + 30.minute }

end
