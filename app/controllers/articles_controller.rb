# frozen_string_literal: true

# Articles Controller
class ArticlesController < ApplicationController
  before_action :confirm_user_login, except: [:show, :index]
  before_action :confirm_valid_user, except: [:show, :index, :new, :create]

  def show
    @article = Article.find(params[:id])
  end

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5).sorted
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = User.find(session[:user_id])
    if @article.save
      flash[:notice] = 'Successfully Created new article'
      redirect_to(article_path(@article))
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @article.update_attributes(article_params)
      flash[:notice] = "Successfully Updated Article: #{@article.title}."
      redirect_to(article_path(@article))
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    flash[:notice] = "Successfully Deleted Article: #{@article.title}."
    redirect_to(articles_path)
  end

  private

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def confirm_valid_user
    @article = Article.find(params[:id])
    unless @article.user.id == session[:user_id] || session[:admin]
      flash[:alert] = "You don't have permission to edit this article... Also how did you get this message?"
      redirect_to(@article)
    end
  end
end
