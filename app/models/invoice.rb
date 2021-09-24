class Invoice < ApplicationRecord

  has_many :line_items, dependent: :destroy
  private
  def set_invoice
    @invoice = Invoice.find(session[:invoice_id])
  end
end
