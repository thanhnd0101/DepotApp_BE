class UploadImagesService
  DEFAULT_IMAGE_DIR = 'assets/images'.freeze
  SUPPORT_EXTENSION = %w[ jpg png ]

  def call(filename, file_path, user_id)
    # store image to location
    unique_id = IDGeneratorService.call.upcase
    extension = filename.split('.').last

    raise "Do not support #{extension} extension" if extension.nil? || SUPPORT_EXTENSION.exclude?(extension)

    image_path = Rails.root.join(DEFAULT_IMAGE_DIR, "#{unique_id}.jpg")
    FileUtils.copy_file(file_path, image_path, preserve=false, dereference=false)

    # create the document
    document = Document.create!({
                       title: filename,
                       user_id: user_id
                     });

    # create to upload image
    UploadMedia.create!({
                          identifier: unique_id,
                          file_name: filename,
                          path: image_path,
                          media_type: UploadMedia::MEDIA_TYPES[:Image],
                          document_id: document.id
                        })

    document
  end
end