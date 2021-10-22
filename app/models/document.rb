class Document < ApplicationRecord
  belongs_to :user
  has_many :line_items
  has_many :orders, through: :line_items
  has_many :upload_media, dependent: :destroy
  before_destroy :ensure_not_referenced_by_any_line_item

  validates :title, :user_id, presence:true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}, allow_blank: true, allow_nil: true
  validates :image_url, allow_blank: true, format: {
    with: /\.(gif|jpg|png|jpeg)\z/i,
    message: "must be a URL for GIF, JPG, or PNG"
  }
  validates :publish, inclusion: {in:[true , false]}

  scope :published, ->{where(publish: true)}

  scope :by_user, ->(user_id){ joins(:user).where(user_id: user_id)}

  scope :related_images, -> {joins(:upload_media)}

  private
  def ensure_not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, 'Line items present')
      throw :abort
    end
  end
end
