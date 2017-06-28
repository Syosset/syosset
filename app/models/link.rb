class Link
  include Mongoid::Document
  include Mongoid::Timestamps
  include Scram::DSL::ModelConditions
  include Concerns::Rankable

  belongs_to :linkable, polymorphic: true
  belongs_to :poster, class_name: "User"

  field :name, type: String
  field :target, type: String
  validates_presence_of :name, :target

  scram_define do
    condition :collaborators do |link|
      if link.linkable.is_a? Concerns::Collaboratable
        link.linkable.send("*collaborators")
      else
        User.all.select{ |u| u.can?(:edit, link.linkable) }.map(&:scram_compare_value).to_a
      end
    end
  end

end
