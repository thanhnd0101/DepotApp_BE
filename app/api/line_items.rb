class LineItems < Grape::API

  desc 'End-points for line items'

  get do
    LineItem.all.to_json
  end

  params do
    requires :document_id, type: Integer
  end
  post do
    document = Document.find(params[:document_id])
    invoice = Invoice.create
    @line_item = LineItem.new({
                                   document_id: document.id,
                                   invoice_id: invoice.id
                                 })
    if @line_item.save
      return @line_item.to_json
    else
      return GoogleJsonResponse.render_error(@line_item.errors)
    end
  end
end