class Link
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Search
  include Scram::DSL::ModelConditions
  include Rankable
  include Escalatable

  belongs_to :linkable, polymorphic: true
  belongs_to :poster, class_name: 'User'

  field :name, type: String
  validates :name, presence: true

  field :icon, type: String

  field :target, type: String
  validates :target, presence: true

  search_in :name, :target
  scram_define do
    condition :collaborators do |link|
      if link.linkable.is_a? Collaboratable
        link.linkable.send('*collaborators')
      else
        User.all.select { |u| u.can?(:edit, link.linkable) }.map(&:scram_compare_value).to_a
      end
    end
  end

  def link
    target
  end
end
