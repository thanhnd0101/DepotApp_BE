class LineItem < ApplicationRecord
  belongs_to :document
  belongs_to :cart, optional: true
  belongs_to :order, optional: true


  def total_price
    document.price * quantity
  end
end
