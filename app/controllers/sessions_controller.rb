class SessionsController < ApplicationController
  def create
    @session = {}
    if get_cookie(:email_cookie)
      respond_to do |format|
        @session[:errors] = "You're already logged in. Logout if this isn't you!"
        format.js { render 'messages/new' }
        format.html { redirect_to root_path, notice: "You're already logged in. Logout if this isn't you!" }
      end
    else
      email = params[:session][:email].downcase
      respond_to do |format|
        if @user = User.find_by(email: email)
          set_cookie(:email_cookie,email)
          format.js { render 'sessions/create' }
          format.html { redirect_to root_path, notice: "You're logged in, send some messages" }
        else
          @session[:errors] = "You don't seem to be in our list, contact us if this is incorrect, and we'll add you ASAP!"
          format.js { render 'sessions/errors' }
          format.html { redirect_to root_path, notice: "You don't seem to be in our list, contact us if this is incorrect, and we'll add you ASAP!" }
        end
      end
    end
  end

  def destroy
    cookies.clear
    session.clear
    redirect_to root_path
  end

end
