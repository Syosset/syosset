class SerializableDay < JSONAPI::Serializable::Resource
  type 'days'

  attributes :color, :updated_at

  has_one :closure do
    data { Closure.active_closure }
  end
end
