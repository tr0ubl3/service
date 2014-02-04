class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :redirect_back

  def current_user
  	@current_user||= User.find(session[:user_id]) if session[:user_id]
  end

  def redirect_back
    redirect_to(session[:return_to] || root_path)
    clear_return_to
  end

  def store_location
    session[:return_to] = request.fullpath
  end

  def update_login_count(user)
    login_count_save = proc do
      user.login_count_increment
    end
    UserMailer.welcome(user).deliver if login_count_save.call.login_count == 1
  end

private
  def check_auth
    unless session[:user_id]
      flash[:notice] = "Please login to see page"
      redirect_to login_path
      store_location
    	return false
    else
      return true
    end
  end

  def clear_return_to
    session.delete(:return_to)
  end
end
