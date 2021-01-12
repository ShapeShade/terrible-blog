# frozen_string_literal: true

# Sessions Controller
class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(username: params[:session][:username].downcase)
    if user&.authenticate(params[:session][:password])
      session[:user_id] = user.id
      session[:username] = user.username
      flash[:notice] = 'Logged in successfully.'
      redirect_to(user)
    else
      flash.now[:alert] = 'Login Failed. (might have been wrong username / password combo)'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    session[:username] = nil
    flash[:notice] = 'Logged out.'
    redirect_to(root_path)
  end
end
