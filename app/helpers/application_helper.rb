module ApplicationHelper

  def related_items(item)
    subcategory = item.subcategory
    items = subcategory.items.active.limit(9) - [item]
    return items
  end


  def cart
    if session[:cart] && current_customer
      begin
        cart = current_customer.carts.find(session[:cart])
        return cart
      rescue
        return nil
      end
    else
      return nil
    end
  end

end
