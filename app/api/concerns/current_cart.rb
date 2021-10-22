module CurrentCart
  def set_cart
    user = AuthorizeApiRequestService.call(request.headers)
    @cart = Cart.pending.find_by(user_id: user.id)
    @cart ||= Cart.create!({
                             user_id: user.id,
                             completed: false
                           });
  end

  private

  def cart_empty?
    @cart.line_items.empty?
  end
end