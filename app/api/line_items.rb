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
    requires :documentId, type: Integer
  end
  post do
    set_cart
    document = Document.find(params[:documentId])
    raise 'Can not add unpublished document' unless document.publish

    @line_item = @cart.add_document(document);
    @line_item.save ? @line_item.to_json : GoogleJsonResponse.render_error(@line_item.errors)
  end

  namespace ':id' do
    namespace :quantity do
      params do
        requires :quantity, type: Integer
      end
      put do
        line_item = LineItem.find(params[:id])
        raise 'Invalid item' unless line_item

        line_item.quantity = params[:quantity]
        line_item.save!
        line_item.as_json
      end
    end

  end
end