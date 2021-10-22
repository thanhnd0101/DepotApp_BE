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
        docs = Cart.where(id: params[:id])
                   .related_images
                   .select(:title, :description, :price,
                           :publish, :file_name, :relative_path,
                           :media_type, :identifier, 'line_items.id as line_item_id',
                           'line_items.quantity as line_item_quantity', 'carts.id as cart_id')
        results = []
        docs.each do |line_item|
          path = get_http_path(line_item.relative_path["public".length..-1])
          results.push(line_item.as_json.merge({
                                           path:  path,
                                         }))
        end
        results
      end
    end
  end

end