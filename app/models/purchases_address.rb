class PurchasesAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :purchase, :postcode, :prefecture_id, :city, :address, :building_name, :phone_number,
                :purchase_id

  # 空の投稿を保存できないようにする
  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postcode, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' } # ３ケタの整数 + ハイフン + ４ケタの整数
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :city
    validates :address
    validates :phone_number, format: { with: /\A\d{11}\z/ } # 11ケタ
  end

  def save
    # 購入情報を保存し、変数purchaseに代入する
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    # 住所を保存する
    # donation_idには、変数donationのidと指定する
    Address.create(postcode: postcode, prefecture_id: prefecture_id, city: city, address: address,
                   building_name: building_name, phone_number: phone_number, purchase_id: purchase.id)
  end
end
