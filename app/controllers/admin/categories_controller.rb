class Admin::CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def new
    @categories = Category.all 
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
  end
  def show
    @category = Category.find(params[:id])
    @products = @category.products.order(created_at: :desc)
  end
  
  private

  def category_params
    params.require(:category).permit(:name, :description)
  end
end


