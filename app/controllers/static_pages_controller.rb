class StaticPagesController < ApplicationController
  before_action :set_user

  def index
    if @user
      gon.messages = @user.get_messages_with_random(150)
    else
      gon.messages = Message.get_random(150)
    end
    @message = Message.new
  end

  def my_messages
    unless @user
      flash[:notice] = "You can't view your messages unless you're signed in"
      return redirect_to root_path
    end
    gon.messages = @user.get_messages
    @message = Message.new
    render 'static_pages/index'
  end

  def thank_you
  end

end
