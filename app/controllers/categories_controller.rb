class CategoriesController < ApplicationController
  before_action :is_admin, except: [:index, :show]

  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end

  def show
    @category = Category.find(params[:id])
    @articles = @category.articles.paginate(page: params[:page], per_page: 5)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "New Category Created."
      redirect_to(@category)
    else
      render 'new'
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(category_params)
      flash[:notice] = "Category Name updated successfully."
      redirect_to(@category)
    else
      render 'edit'
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def is_admin
    unless session[:admin]
      flash[:alert] = "You have to be logged in as an admin to do this action."
      redirect_to(categories_path)
    end
  end
end
