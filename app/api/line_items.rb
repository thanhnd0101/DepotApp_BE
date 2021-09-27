class LineItems < Grape::API
  desc 'End-points for line items'
  helpers CurrentCart

  before do
    authorize
  end

  get do
    LineItem.all.to_json
  end

  params do
    requires :document_id, type: Integer
    optional :cart_id, type: Integer
  end
  post do
    document = Document.find(params[:document_id])
    cart = if !params[:cart_id].nil?
                Cart.find(params[:cart_id])
              else
                Cart.create
              end
    @line_item = cart.add_document(document);

    if @line_item.save
      return @line_item.to_json
    else
      return GoogleJsonResponse.render_error(@line_item.errors)
    end
  end
end