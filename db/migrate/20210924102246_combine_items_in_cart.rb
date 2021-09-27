class CombineItemsInCart < ActiveRecord::Migration[5.0]
  def change

    Cart.all.each do |cart|
      sums = cart.line_items.group(:document_id).sum(:quantity)

      sums.each do |document_id, quantity|
        if quantity > 1
          cart.line_items.where(document_id: document_id).delete_all

          item = cart.line_items.build({
                                            document_id:document_id
                                          })
          item.quantity = quantity
          item.save!
        end
      end
    end
  end


end
