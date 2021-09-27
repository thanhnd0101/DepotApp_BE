# Cart class
class Cart < ApplicationRecord

  has_many :line_items, dependent: :destroy

  def set_cart
    @cart = Cart.find(session[:cart_id])
  end

  def add_document(document)
    current_line_item = line_items.find_by(document_id: document.id);
    if current_line_item
      current_line_item.quantity = 0 unless current_line_item.quantity
      current_line_item.quantity += 1
    else
      current_line_item = line_items.build(document_id:document.id)
    end
    current_line_item
  end

  def total_price
    line_items.to_a.sum(&:total_price)
  end
end
