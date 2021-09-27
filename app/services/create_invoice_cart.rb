module DamView
  class CreateCartService

    def call
      set_cart
    end

    private

    def set_cart
      @cart = Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end
  end
end
