#encoding: utf-8
class PublicController < ApplicationController

  skip_before_filter :authenticate_customer!

  def index
    @categories = Category.active
    @category = Category.active.first
    @items = Item.active.limit(8)
    @banners = Banner.active_image_url
    @banners.push(nil)
    @banner = Banner.active.all
    @app_info = AppInfo.first
  end

  def termos
  	@categories = Category.active
    @category = Category.active.first
  end

  def quemsomos
  	@categories = Category.active
    @category = Category.active.first
  end

  def contato
  	@categories = Category.active
    @category = Category.active.first
  end
  
end
