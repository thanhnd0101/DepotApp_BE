class Users < Grape::API
  desc 'End-points for user'

  params do
    requires :name, type: String
    requires :password, type: String
  end
  post do
    @user = User.create!({
                           name: params[:name],
                           password: params[:password]
                         }).as_json
  end

  get do
    User.order(:name).to_json
  end

  namespace ':id' do
    params do
      requires :password, type: String
    end
    put do
      @user = User.find(params[:id])
      @user.update({
                     password: params[:password]
                   })
    end

    get do
      @user = User.find(params[:id]).to_json
    end

    get :documents do
      docs = Document.by_user(params[:id]).related_images.select(:title, :description, :price, :publish, :file_name, :relative_path, :media_type, :identifier)
      results = []
      docs.each do |doc|
        path = "#{request.host_with_port}#{doc.relative_path["public".length..-1]}"
        results.push({
                       title: doc.title,
                       description: doc.description,
                       price: doc.price,
                       publish: doc.publish,
                       file_name: doc.file_name,
                       path:  path,
                       media_type: doc.media_type,
                       identifier: doc.identifier
                     })
      end
      results
    end

    get :carts do
      docs = Cart.by_user(params[:id])
                 .related_images
                 .select(:title, :description, :price,
                         :publish, :file_name, :relative_path,
                         :media_type, :identifier, 'line_items.id as line_item_id',
                         'line_items.quantity as line_item_quantity', 'carts.id as cart_id')
      results = []
      docs.each do |doc|
        path = "#{request.host_with_port}#{doc.relative_path["public".length..-1]}"
        results.push(doc.as_json.merge({
                       path:  path,
                     }))
      end
      results
    end

    get :orders do
      docs = Order.by_user(params[:id])
                 .related_images
                 .select(:title, :description, :price,
                         :publish, :file_name, :relative_path,
                         :media_type, :identifier, 'line_items.id as line_item_id',
                         'line_items.quantity as line_item_quantity', 'orders.id as order_id')
      results = []
      docs.each do |doc|
        path = "#{request.host_with_port}#{doc.relative_path["public".length..-1]}"
        results.push(doc.as_json.merge({
                                         path:  path,
                                       }))
      end
      results
    end
  end
end