class UploadImagesService
  DEFAULT_IMAGE_RELATIVE_DIR = 'public/assets/images'.freeze
  SUPPORT_EXTENSION = %w[ jpg png ]

  def call(filename, file_path, user_id)
    # store image to location
    unique_id = IDGeneratorService.call.upcase
    extension = filename.split('.').last

    raise "Do not support #{extension} extension" if extension.nil? || SUPPORT_EXTENSION.exclude?(extension)

    relative_image_path = DEFAULT_IMAGE_RELATIVE_DIR + "/#{unique_id}.jpg"
    absolute_image_path = Rails.root.join(relative_image_path)
    FileUtils.copy_file(file_path, absolute_image_path, preserve=false, dereference=false)

    # create the document
    document = Document.create!({
                       title: filename,
                       user_id: user_id,
                       publish: false
                       });

    # create to upload image
    UploadMedia.create!({
                          identifier: unique_id,
                          file_name: filename,
                          relative_path: relative_image_path,
                          media_type: UploadMedia::MEDIA_TYPES[:Image],
                          document_id: document.id
                        })

    document
  end
end