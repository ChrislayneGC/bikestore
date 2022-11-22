#encoding: utf-8
class CategoriesController < ApplicationController

  skip_before_filter :authenticate_customer!

  def show
    @categories = Category.active
    @category = Category.find(params[:id])
    @subcategories = @category.subcategories.active
    @items = Kaminari.paginate_array(@category.items).page(params[:page]).per(12)
    
    @promos = @items
  end

end
