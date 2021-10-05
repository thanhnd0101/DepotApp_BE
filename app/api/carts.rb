class Carts < Grape::API
  desc 'End-points for cart'

  before do
    authorize
  end

  get do
    Cart.all.as_json
  end

  namespace ':id' do
    namespace :lineitems do
      get do
        Cart.joins(:line_items).where(id: params[:id]).as_json
      end
    end
  end

end