class LineItem < ApplicationRecord
  belongs_to :document
  belongs_to :invoice
end
