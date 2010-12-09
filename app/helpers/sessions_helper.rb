module SessionsHelper
  def sign_in(user,remember)
    session[:user_id] = user.id
    
    if remember == "1" then
      cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    end
    
    current_user = user
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) || user_from_remember_token
  end
  
  def current_user?(user)
    @current_user == user
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def sign_out
    session[:user_id] = nil
    cookies.delete :remember_token
    current_user = nil
  end
  
  def deny_access
    store_location
    redirect_to signin_path, :notice => "Please sign in to access this page."
  end
  
  def redirect_back_or(default)
    redirect_to (session[:return_to] || default)
    clear_location
  end
  
  private
    def user_from_remember_token
      User.authenticate_with_salt(*remember_token)
    end
  
    def remember_token
      cookies.signed[:remember_token] || [nil,nil]
    end

    def store_location
      session[:return_to] = request.fullpath
    end
    
    def clear_location
      session[:return_to] = nil
    end
end
