# frozen_string_literal: true
class Orders < Grape::API
  desc 'End-points for orders'

  helpers CurrentCart

  namespace do
    before do
      authorize
      set_cart
    end

    params do
      requires :name, type: String
      requires :address, type: String
      requires :email, type: String
      requires :pay_type, type: String
    end
    post do

      # ensure curren cart isn't empty
      redirect '/api/dam' if cart_empty?
      @order = Order.new({
                           name: params[:name],
                           address: params[:address],
                           email: params[:email],
                           pay_type: Order.pay_types[params[:pay_type]],
                           user_id: session[:user_id]
                         })
      @order.add_line_items_from_cart(@cart)
      @order.save!

      # reset cart
      session[:cart_id] = nil

      @order.as_json
    rescue StandardError => e
      {
        message: e.message
      }
    end
  end

  namespace do
    before do
      authorize
    end

    get do
      Order.all.to_json
    end
  end
end