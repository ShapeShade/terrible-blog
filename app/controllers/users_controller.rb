# frozen_string_literal: true

# Users Controller
class UsersController < ApplicationController
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
      flash[:notice] = "Welcome to Terrible Blog #{@user.username}, The signup was successful!"
      redirect_to(@user)
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:notice] = "#{@user.username} account information has successfully updated."
      redirect_to(@user)
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
