class SerializableClosure < JSONAPI::Serializable::Resource
  type 'closures'

  attributes :type, :markdown, :start_date, :end_date
end
