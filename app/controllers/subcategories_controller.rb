#encoding: utf-8
class SubcategoriesController < ApplicationController

  skip_before_filter :authenticate_customer!

  def show
    @categories = Category.active
    @subcategory = Subcategory.find(params[:id])
    @category = @subcategory.category
    @items = @subcategory.items.active.order(highlight: :desc).page(params[:page]).per(12)
    @subcategories = @category.subcategories - [@subcategory]
  end

end
