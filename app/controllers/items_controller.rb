#encoding: utf-8
class ItemsController < ApplicationController

  skip_before_filter :authenticate_customer!

  def show
    @categories = Category.active
    @item = Item.friendly.find(params[:id])
    @subcategory = @item.subcategory
    @category = @subcategory.category
    @subcategories = @category.subcategories - [@subcategory]
  end

end
