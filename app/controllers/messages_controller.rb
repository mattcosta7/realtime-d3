class MessagesController < ApplicationController
  before_action :set_user
  # POST /messages
  def create
    @message = Message.new(message_params)
    respond_to do |format|
      if @message.save
        format.js { render 'messages/create' }
        format.html { redirect_to thank_you_path, notice: "Thanks for sending #{@message.receiver.fname} a message!" }
      else
        format.js { render 'messages/errors' }
        format.html { render :'static_pages/index' }
      end
    end
  end

  private
    # Only allow a trusted parameter "white list" through.
    def message_params
      params.require(:message).permit(:sender_id, :receiver_id, :body)
    end
end
