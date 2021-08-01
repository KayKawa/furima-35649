class PurchasesAddress
  include ActiveModel::Model
  attr_accessor :user, :item, :purchase, :postcode, :prefecture_id, :city, :address, :building_name, :phone_number
end
