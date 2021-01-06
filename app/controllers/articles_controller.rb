class ArticlesController < ApplicationController
  def show
    @article = Article.find(params[:id])
  end

  def index
    @articles = Article.sorted
  end

  def new
    @article = Article.new
    @form_text = 'Create Article'
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = 'Successfully Created new article'
      redirect_to(article_path(@article))
    else
      render 'new'
    end
  end

  def edit
    @article = Article.find(params[:id])
    @form_text = 'Save Article'
  end

  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(article_params)
      flash[:notice] = "Successfully Updated Article: #{@article.title}."
      redirect_to(article_path(@article))
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    flash[:notice] = "Successfully Deleted Article: #{@article.title}."
    redirect_to(articles_path)
  end

  private

  def article_params
    params.require(:article).permit(:title, :description)
  end

end
