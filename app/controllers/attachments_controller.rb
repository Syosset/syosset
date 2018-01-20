class AttachmentsController < ApplicationController
  before_action :get_attachable

  def create
    attachment = Attachment.create!(attachable: @attachable, file: params[:file])
    render json: { filename: attachment.file.url }
  end

  private
  def get_attachable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return @attachable =  $1.classify.constantize.find(value)
      end
    end
    nil
  end
end
