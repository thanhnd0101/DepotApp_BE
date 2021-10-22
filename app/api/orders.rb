require 'zip'
# frozen_string_literal: true
class Orders < Grape::API
  desc 'End-points for orders'

  helpers CurrentCart

  namespace do
    before do
      authorize
    end

    params do
    end
    post do
      set_cart
      # ensure curren cart isn't empty
      raise 'Cart is empty' if cart_empty?
      user = AuthorizeApiRequestService.call(request.headers)
      @order = Order.new({
                           name: user[:name],
                           address: user[:address] || 'abc',
                           email: user[:email] || 'test@gmail.com',
                           pay_type: Order.pay_types['Cash'],
                           user_id: user.id
                         })
      @order.add_line_items_from_cart(@cart)
      @order.save!

      #complete cart
      @cart.completed = true;
      @cart.save!

      redirect "/api/orders/#{@order.id}/download"
    end
  end

  namespace ':id' do
    namespace :lineitems do
      get do
        line_items = Order.where(id: params[:id])
                          .related_images
                          .select(:title, :description, :price,
                                  :publish, :file_name, :relative_path,
                                  :media_type, :identifier, 'line_items.id as line_item_id',
                                  'line_items.quantity as line_item_quantity', 'orders.id as order_id')
        results = []
        line_items.each do |line_item|
          path = get_http_path(line_item.relative_path["public".length..-1])
          results.push(line_item.as_json.merge({
                                                 path: path,
                                               }))
        end
        results
      end
    end

    namespace :download do
      get do
        user = AuthorizeApiRequestService.call(request.headers)
        line_items = Order.where(id: params[:id])
                          .related_images
                          .select(:title, :description, :price,
                                  :publish, :file_name, :relative_path,
                                  :media_type, :identifier, 'line_items.id as line_item_id',
                                  'line_items.quantity as line_item_quantity', 'orders.id as order_id')
        begin
          unique_id = IDGeneratorService.call
          temp = Tempfile.new ["#{user.name}_#{unique_id}_", '.zip']
          Zip::File.open(temp.path, create:true) do |zipfile|
            line_items.each do |line_item|
              absolute_image_path = Rails.root.join(line_item.relative_path)
              zipfile.add line_item.file_name, absolute_image_path.cleanpath.to_s
            end
          end
        rescue Errno::ENOENT, IOError => e
          Rails.logger.error e.message
          temp.close
        end
        content_type 'application/octet-stream'
        headers['Content-Disposition'] = "attachment; filename=#{File.basename(temp.path)}"
        env['api.format'] = :binary
        File.open(temp.path).read
      end
    end

  end
end