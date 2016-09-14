class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private
  def set_user
    @user = User.find_by(email: get_cookie(:email_cookie))
    gon.user_id = @user.id if @user
  end
  def get_cookie(key)
    cookies.encrypted[key]
  end
  def set_cookie(key, value)
    cookies.encrypted[key] = value
  end
end
