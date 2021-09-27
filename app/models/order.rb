class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy

  enum pay_types: {
    'Check' => 0,
    'Credit card' => 1,
    'Purchase order' => 2
  }

  validates :name, :address, :email, presence: true
  validates :pay_type, inclusion: pay_types.values

  def add_line_items_from_cart(cart_model)
    raise TypeError, 'cart_model must be Cart' unless cart_model.is_a?(Cart)

    cart_model.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end
end
