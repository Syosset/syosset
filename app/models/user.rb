class User
  include Mongoid::Document
  include Mongoid::Slug
  include Authorizable
  include Permissible, Collaborator
  include Alertable
  include Badged
  include Profiled, Onboarded, Scheduled

  paginates_per 12
  field :bot, type: Boolean, default: false

  slug :username

  def username
    match = email.match(/^([a-z]+)\@.*$/)
    match.nil? ? nil : match[1]
  end

  def staff?
    super_admin || (/^[a-z]+\@syosset\.k12\.ny\.us$/ =~ email) == 0
  end
end
