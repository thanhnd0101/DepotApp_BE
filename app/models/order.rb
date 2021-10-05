class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy
  belongs_to :user
  has_many :documents, through: :line_items
  has_many :upload_media, through: :documents

  scope :by_user, ->(user_id){ joins(:user).where(user_id: user_id)}
  scope :related_images, -> { joins(:upload_media)}

  enum pay_types: {
    'Cash' => 0,
    'Credit card' => 1,
  }

  validates :name, :address, :email, :user_id, presence: true
  validates :pay_type, inclusion: pay_types.values

  def add_line_items_from_cart(cart_model)
    raise TypeError, 'cart_model must be Cart' unless cart_model.is_a?(Cart)

    cart_model.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end
end
