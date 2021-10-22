class Users < Grape::API
  desc 'End-points for user'
  helpers CurrentCart
  helpers Path

  params do
    requires :name, type: String
    requires :password, type: String
    requires :email, type: String
    requires :address, type: String
  end
  post do
    @user = User.create!({
                           name: params[:name],
                           email: params[:email],
                           address: params[:address],
                           password: params[:password]
                         }).as_json
  end

  get do
    User.order(:name).to_json
  end

  namespace ':id' do
    params do
      optional :password, type: String
      optional :email, type: String
      optional :address, type: String
    end
    put do
      @user = User.find(params[:id])
      needToUpdateAttributes = {}
      needToUpdateAttributes[:password] = params[:password] unless params[:password].nil?
      needToUpdateAttributes[:email] = params[:email] unless params[:email].nil?
      needToUpdateAttributes[:address] = params[:address] unless params[:address].nil?

      @user.update!(needToUpdateAttributes)
    end

    get do
      @user = User.find(params[:id]).to_json
    end

    get :documents do
      docs = Document.by_user(params[:id]).related_images.select(:id, :title, :description, :price, :publish, :file_name, :relative_path, :media_type, :identifier)
      results = []
      docs.each do |doc|
        path = get_http_path(doc.relative_path["public".length..-1])
        results.push({
                       id: doc.id,
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

    get :cart do
      carts = Cart.by_user(params[:id])
                 .related_images
                 .select(:title, :description, :price,
                         :publish, :file_name, :relative_path,
                         :media_type, :identifier, 'line_items.id as line_item_id',
                         'line_items.quantity as line_item_quantity', 'carts.id as cart_id',
                         'documents.id as document_id')
      results = []
      carts.each do |line_item|
        path = get_http_path(line_item.relative_path["public".length..-1])
        results.push(line_item.as_json.merge({
                       path:  path,
                     }))
      end
      results
    end

    get :orders do
      orders = Order.by_user(params[:id])
                 .select("*")
      orders.as_json
    end

  end
end