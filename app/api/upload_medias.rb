class UploadMedias < Grape::API
  desc 'End-point for uploading medias'

  before do
    authorize
  end

  get do
    UploadMedia.all.as_json
  end

  namespace :uploadimages do
    get do
      UploadMedia.images.as_json
    end

    params do
      requires :file
    end
    post do
      UploadImagesService.new.call(params[:file][:filename], params[:file][:tempfile], session[:user_id]).as_json
    end
  end
end