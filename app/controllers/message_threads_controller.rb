class MessageThreadsController < ApplicationController
  before_action :authenticate_user!
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
    return nil unless current_user == @thread.user
    message = @thread.messages.create(message: params[:text], user: current_user)
    message.notify_spagett
    render :json => message.to_json
  end

  private
    def get_thread
      @thread = MessageThread.find(params[:id])
    end

end
