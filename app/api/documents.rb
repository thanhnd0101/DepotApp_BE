class Documents < Grape::API
  desc 'End-point for documents'

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
    'Welcome to documents get api'
  end
end