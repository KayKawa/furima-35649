class Purchase < ApplicationRecord
  has_one :shipping_address
end
