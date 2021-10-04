class UploadMedia < ApplicationRecord
  belongs_to :document

  MEDIA_TYPES = {
    Image: 'Image',
    Video: 'Video',
    Others: 'Others'
  }.freeze

  validates :media_type, inclusion: MEDIA_TYPES.values

  scope :images, -> {where(media_type: MEDIA_TYPES[:Image])}

end
