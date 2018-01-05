class SerializableDay < JSONAPI::Serializable::Resource
  type 'days'
  id { 'current_day_color' }

  attributes :color

  has_one :closure do
    data { Closure.active_closure }
  end
end
