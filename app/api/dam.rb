class Dam < Grape::API
  desc 'End-points for dam view'

  helpers CurrentCart

  before do
    set_cart
  end
  get do
    Document.joins(:upload_media).merge(Document.published).as_json
  end


end