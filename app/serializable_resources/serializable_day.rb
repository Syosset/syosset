class SerializableDay < JSONAPI::Serializable::Resource
  type 'days'
  id { 'current_day_color' } # TEMPORARY FIX for Syosset/syosset#109

  attributes :color

  has_one :closure do
    data { Closure.active_closure }
  end
end
