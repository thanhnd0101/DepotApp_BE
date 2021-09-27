module CurrentCart
  def set_cart
    if session[:cart_id]
      @cart = Cart.find(session[:cart_id])
    else
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end
  end

  private
  def cart_empty?
    @cart.line_items.empty?
  end
end