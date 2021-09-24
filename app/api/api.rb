class API < Grape::API
  mount Say => '/say'
  mount Documents => '/documents'
  mount Dam => '/dam'
  mount LineItems => '/lineitems'

  rescue_from :all do |e|
    rack_response({
                    status: e.status,
                    error_msg: e.message
                  }.to_json, 400)
  end
end