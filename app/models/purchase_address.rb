class PurchaseAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postcode, :prefecture_id, :city, :address, :building_name, :phone_number, :token

  # 空の投稿を保存できないようにする
  with_options presence: true do
    validates :token
    validates :postcode, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Enter it as follows (e.g. 123-4567)' } # ３ケタの整数 + ハイフン + ４ケタの整数
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :city
    validates :address
    validates :phone_number, format: { with: /\A\d{11}\z/, message: 'is too short' } # 11ケタ以内
  end
  validates :phone_number, format: { with: /\A[0-9]+\z/, message: 'is invalid.Input only half-width number' } # 半角数字のみ

  def save
    # 購入情報を保存
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    # 住所を保存
    ShippingAddress.create(postcode: postcode, prefecture_id: prefecture_id, city: city, address: address,
                           building_name: building_name, phone_number: phone_number, purchase_id: purchase.id)
  end
end
