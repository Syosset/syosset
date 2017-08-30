class IntegrationValidator < ActiveModel::Validator

  def validate(record)
    raise "Unable to validate a model that isn't an integration." unless record.is_a? Integration

    begin
      record.create_provider
    rescue => error
      record.errors[:integration] << error.message
    end 
  end

end