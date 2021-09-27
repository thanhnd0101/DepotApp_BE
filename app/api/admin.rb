class Admin < Grape::API
  desc 'End-points for admin'

  get do
    @total_orders = Order.count
  end
end