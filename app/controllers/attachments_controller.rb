class AttachmentsController < ApplicationController
  before_action :get_attachable
  before_action :get_user

  def create
    attachment = Attachment.create!(attachable: @attachable, user: @user, file: params[:file])
    render json: { filename: attachment.file.url }
  end

  private

  def get_attachable
    @attachable = params[:attachable_type].classify.constantize.find(params[:attachable_id])
  end

  def get_user
    @user = User.find(params[:user_id])
  end
end
