class ApplicationController < ActionController::Base

  private

  def confirm_user_login
    unless session[:user_id]
      flash[:alert] = "You have to log in to do that."
      redirect_to(login_path)
    end
  end

  def logout_user_session
    session[:user_id] = nil
    session[:username] = nil
    session[:admin] = nil
  end

end
