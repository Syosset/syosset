class User
  include Mongoid::Document
  include Mongoid::Slug
  include Alerts
  include Attachable
  include Authorizable
  include Badged
  include Collaborator
  include Onboarded
  include Permissible
  include Profiled
  include Scheduled

  paginates_per 12
  field :bot, type: Boolean, default: false

  slug :username

  def username
    match = email.match(/^([a-z]+)\@.*$/)
    match.nil? ? nil : match[1]
  end

  def staff?
    super_admin || (/^[a-z]+\@syosset\.k12\.ny\.us$/ =~ email).zero?
  end
end
