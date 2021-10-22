class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy
  belongs_to :user
  has_many :documents, through: :line_items
  has_many :upload_media, through: :documents

  scope :by_user, ->(user_id){ joins(:user).where(user_id: user_id)}
  scope :related_images, -> { joins(:upload_media)}
  scope :pending, ->{where(completed:false)}
  scope :by_user, ->(user_id){ where(user_id: user_id)}

  enum pay_types: {
    'Cash' => 0,
    'Credit card' => 1,
  }

  validates :name, :address, :email, :user_id, :total_price, presence: true
  validates :pay_type, inclusion: pay_types.values

  def add_line_items_from_cart(cart_model)
    raise TypeError, 'cart_model must be Cart' unless cart_model.is_a?(Cart)

    self.total_price = 0
    cart_model.line_items.each do |item|
      item.cart_id = nil
      line_items << item
      self.total_price = self.total_price + item.total_price
    end
  end
end
