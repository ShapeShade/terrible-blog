# frozen_string_literal: true

# Users Controller
class UsersController < ApplicationController
  before_action :confirm_user_login, except: [:show, :index, :new, :create]
  before_action :confirm_valid_user, except: [:show, :index, :new, :create]

  def index
    @users = User.paginate(page: params[:page], per_page: 5).sorted
  end

  def show
    @user = User.find(params[:id])
    @articles = @user.articles.paginate(page: params[:page], per_page: 5).sorted
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      session[:username] = @user.username
      flash[:notice] = "Welcome to Terrible Blog #{@user.username}, The signup was successful!"
      redirect_to(@user)
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @user.update_attributes(user_params)
      flash[:notice] = "#{@user.username} account information has successfully updated."
      redirect_to(@user)
    else
      render 'edit'
    end
  end

  def destroy
    session[:user_id] = nil
    session[:username] = nil
    @user.destroy
    flash[:notice] = "Account and all associated articles have successfully been removed."
    redirect_to(root_path)
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def confirm_valid_user
    @user = User.find(params[:id])
    unless @user.id == session[:user_id]
      flash[:alert] = "You don't have permission to edit this user... And how did you get this message?"
      redirect_to(@user)
    end
  end
end
