class RankablesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:sort]
  before_action :get_model

  def sort
    rankable_params[@model.name.downcase].each_with_index do |id, index|
      result = @model.find(id)
      authorize result, :edit
      result.update!(priority: index+1)
    end
  end

  def get_model
    begin
      @model = rankable_params.to_h.keys.first.classify.constantize
    rescue NameError => err
      render :nothing => true, :status => 404
    end
  end

  def rankable_params
    h = {}
    ObjectSpace.each_object(Class).select { |c| c.included_modules.include? Concerns::Rankable }
      .each { |m| h[m.to_s.downcase.to_sym] = [] }
    params.permit(h)
  end
end