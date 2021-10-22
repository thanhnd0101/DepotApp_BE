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
      requires :files, type: Array
    end
    post do
      user = AuthorizeApiRequestService.call(request.headers)
      UploadImagesService.new.call(params[:files], user.id).as_json
    end
  end
end