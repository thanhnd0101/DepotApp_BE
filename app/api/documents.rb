
class Documents < Grape::API
  desc 'End-point for documents'

  before do
    authorize
  end

  params do
    requires :title, type:String, desc: "Document's title"
    requires :price, type: BigDecimal
    optional :description, type:String
    optional :image_url, type:String
  end
  post do
    Document.create!({
                       title: params[:title],
                       description: params[:description],
                       image_url: params[:image_url],
                       price: params[:price],
                     })
    {
      message:"Success",
      status: 200
    }
  end

  get do
    Document.all.as_json
  end

  def who_bought
    @document = Document.find(params[:id])
    @lastest_order = @document.orders.order(:updated_at).last
    'Atom' if stale?(@lastest_order)
  end
end