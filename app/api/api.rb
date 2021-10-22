class API < Grape::API

  # version 'v1', using: :path
  helpers do
    def session
      env['rack.session']
    end
  end
  helpers AuthorizationConcern

  rescue_from :all do |e|
    rack_response({
      error_msg: e.message
    }.to_json, 400)
  end



  mount Say => '/say'
  mount Documents => '/documents'
  mount Dam => '/dam'
  mount LineItems => '/lineitems'
  mount Carts => '/carts'
  mount Orders => '/orders'
  mount Users => '/users'
  mount Login => '/login'
  mount Sessions => '/sessions'
  mount Admin => '/admin'
  mount UploadMedias => '/uploadmedias'
  mount MarketplaceApi => '/marketplace'
end