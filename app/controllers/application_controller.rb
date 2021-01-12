class ApplicationController < ActionController::Base

  private

  def confirm_user_login
    unless session[:user_id]
      flash[:alert] = "You have to log in to do that."
      redirect_to(login_path)
    end
  end

end
