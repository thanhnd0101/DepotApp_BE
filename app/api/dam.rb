class Dam < Grape::API
  desc 'End-points for dam view'

  helpers CurrentCart

  before do
    set_cart
  end
  get do
    redirect "/api/documents"
  end


end