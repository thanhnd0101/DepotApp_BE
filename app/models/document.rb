class Document < ApplicationRecord
  has_many :line_items
  has_many :orders, through: :line_items
  has_many :upload_media, dependent: :destroy
  before_destroy :ensure_not_referenced_by_any_line_item

  validates :title, :user_id, presence:true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}, allow_blank: true, allow_nil: true
  validates :image_url, allow_blank: true, format: {
    with: /\.(gif|jpg|png)\z/i,
    message: "must be a URL for GIF, JPG, or PNG"
  }

  private
  def ensure_not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, 'Line items present')
      throw :abort
    end
  end
end
