class SupportChannel < ApplicationCable::Channel
  def subscribed
    thread = MessageThread.find(params[:thread])
    stream_for thread if current_user == thread.user
  end
end
