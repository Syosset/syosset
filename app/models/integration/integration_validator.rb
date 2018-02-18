class IntegrationValidator < ActiveModel::Validator

  def validate(record)
    raise "Unable to validate a model that isn't an integration." unless record.is_a? Integration

    if Integration.providers[record.provider_id].nil?
      record.errors[:provider_id] << 'Invalid provider ID.'
      return
    end

    begin
      record.create_provider
    rescue Exception => error
      record.errors[:integration] << error.message.downcase
    end
  end

end