class MarketplaceApi < Grape::API
  desc 'Endpoint for marketplace'
  get do
    docs = Document.published.related_images.select(:id, :title, :description, :price, :publish, :file_name, :relative_path, :media_type, :identifier)
    results = []
    docs.each do |doc|
      path = "http://#{request.host_with_port}#{doc.relative_path["public".length..-1]}"
      results.push({
                     id: doc.id,
                     title: doc.title,
                     description: doc.description,
                     price: doc.price,
                     publish: doc.publish,
                     file_name: doc.file_name,
                     path: path,
                     media_type: doc.media_type,
                     identifier: doc.identifier
                   })
    end
    results
  end
end