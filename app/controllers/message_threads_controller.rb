class MessageThreadsController < ApplicationController
  before_action :authenticate_user!, except: [:send_message]
  skip_before_action :verify_authenticity_token, only: [:send_message]
  before_action :get_thread, only: [:read_messages, :send_message]

  def create
    return nil unless current_user.staff?

    @thread = MessageThread.thread_for(current_user)
    @thread.notify_spagett
    render :plain => "/threads/#{@thread.id}"
  end

  def read_messages
    return nil unless current_user == @thread.user
    render :json => @thread.messages.to_a.map(&:to_json)
  end

  def send_message
    user = current_holder
    if current_holder.bot
      user = User.find(params[:user_id])
    else
      return nil unless user == @thread.user
    end

    message = @thread.messages.create(message: params[:text], user: user)
    message.notify_spagett unless current_holder.bot
    render :json => message.to_json
  end

  private
    def get_thread
      @thread = MessageThread.find(params[:id])
    end

end
