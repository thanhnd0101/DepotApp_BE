module CurrentOrder
  def set_order
    if session[order_id]
      @order = Cart.find(session[:order_id])
    else
      @order = Cart.create
      session[:order_id] = @order.id
    end
  end
end