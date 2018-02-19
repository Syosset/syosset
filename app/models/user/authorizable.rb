module Authorizable
  extend ActiveSupport::Concern

  included do
    has_many :authorizations, autosave: true
  end
end