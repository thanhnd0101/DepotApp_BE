class Document < ApplicationRecord
  validates :title, :price, presence:true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :image_url, allow_blank: true, format: {
    with: /\.(gif|jpg|png)\z/i,
    message: "must be a URL for GIF, JPG, or PNG"
  }
end
