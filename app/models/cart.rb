# Cart class
class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy
  belongs_to :user
  has_many :documents, through: :line_items
  has_many :upload_media, through: :documents

  validates :user_id, presence: true
  validates :completed, inclusion: {in:[true , false]}

  scope :by_user, ->(user_id){ joins(:user).where(user_id: user_id)}
  scope :related_images, -> { joins(:upload_media)}
  scope :pending, ->{where(completed:false)}

  def add_document(document)
    current_line_item = line_items.find_by(document_id: document.id);
    if current_line_item
      current_line_item.quantity = 0 unless current_line_item.quantity
      current_line_item.quantity += 1
    else
      current_line_item = line_items.build(document_id: document.id, quantity:1)
    end
    current_line_item
  end

  def total_price
    line_items.to_a.sum(&:total_price)
  end
end
