module CurrentOrder
  def set_order
    user = AuthorizeApiRequestService.call(request.headers)
    @order = Order.pending.by_user(user.id)
    @order ||= Order.create!({
                               user_id: user.id,
                               completed: false
                             });
  end
end