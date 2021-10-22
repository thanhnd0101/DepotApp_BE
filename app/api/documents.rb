class Documents < Grape::API
  desc 'End-point for documents'

  helpers Path

  before do
    authorize
  end

  get do
    Document.all.as_json
  end

  namespace ':id' do
    get do
      docs = Document.where(id: params[:id]).related_images.select(:id, :title, :description, :price, :publish, :file_name, :relative_path, :media_type, :identifier)
      results = []
      docs.each do |doc|
        path = get_http_path(doc.relative_path["public".length..-1])
        results.push({
                       id: doc.id,
                       title: doc.title,
                       description: doc.description,
                       price: doc.price,
                       publish: doc.publish,
                       file_name: doc.file_name,
                       path:  path,
                       media_type: doc.media_type,
                       identifier: doc.identifier
                     })
      end
      results
    end

    params do
      optional :title, type: String
      optional :description, type: String
      optional :price, type: BigDecimal
      optional :publish, type: Boolean
    end
    put do
      doc = Document.find(params[:id])
      needToUpdateAttributes = {}
      needToUpdateAttributes[:title] = params[:title] unless params[:title].nil?
      needToUpdateAttributes[:description] = params[:description] unless params[:description].nil?
      needToUpdateAttributes[:price] = params[:price] unless params[:price].nil?
      needToUpdateAttributes[:publish] = params[:publish] unless params[:publish].nil?
      doc.update!(needToUpdateAttributes)
    end

  end

end