
class Documents < Grape::API
  desc 'End-point for documents'

  before do
    authorize
  end

  # params do
  #   requires :title, type:String, desc: "Document's title"
  #   requires :price, type: BigDecimal
  #   optional :description, type:String
  #   requires :upload_image
  # end
  # post do
  #
  #   Document.create!({
  #                      title: params[:title],
  #                      description: params[:description],
  #                      image_url: params[:image_url],
  #                      price: params[:price],
  #                      user_id:session[:user_id],
  #                    })
  #   {
  #     message:"Success",
  #     status: 200
  #   }
  # end

  get do
    Document.all.as_json
  end

  namespace ':id' do
    get do
      Document.find(params[:id]).as_json
    end
    namespace :publish do
      put do
        doc = Document.find(params[:id])
        doc.publish= true;
        doc.save!
      end
      delete do
        doc = Document.find(params[:id])
        doc.publish= false;
        doc.save!
      end
    end
  end
end