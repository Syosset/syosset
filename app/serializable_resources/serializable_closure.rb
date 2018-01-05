class SerializableClosure < JSONAPI::Serializable::Resource
  type 'closures'

  attributes :type, :content, :start_date, :end_date
end
