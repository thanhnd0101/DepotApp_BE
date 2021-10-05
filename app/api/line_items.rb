class LineItems < Grape::API
  desc 'End-points for line items'
  helpers CurrentCart

  before do
    authorize
    set_cart
  end

  get do
    LineItem.all.to_json
  end

  params do
    requires :document_id, type: Integer
  end
  post do
    document = Document.find(params[:document_id])
    raise 'Can not add unpublished document' unless document.publish

    @line_item = @cart.add_document(document);
    @line_item.save ? @line_item.to_json : GoogleJsonResponse.render_error(@line_item.errors)
  end
end