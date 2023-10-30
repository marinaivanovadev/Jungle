class Admin::DashboardController < ApplicationController
  def index
    @product_count = Product.count
    @category_count = Category.count
  end
  
  def show
  end
end
