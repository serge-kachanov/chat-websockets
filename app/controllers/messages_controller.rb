class MessagesController < ApplicationController

  def new
    @message = Message.new
  end

  def create
    message = Message.create(message_params)
    if message.save
      WebsocketRails[:messages].trigger('new', message)
      render json: { success: true }
    end
  end

  def message_params
    params.require(:message).permit(:text, :user)
  end

end
