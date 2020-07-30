module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    return unless (user_id = session[:user_id])

    @current_user ||= User.find_by(id: user_id)
  end

  def current_user?(user)
    user == current_user
  end

  def logged_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
    redirect_to root_path
  end

  def require_login
    return unless current_user.nil?

    flash[:danger] = 'Please log in.'
    redirect_to login_url
  end
end
