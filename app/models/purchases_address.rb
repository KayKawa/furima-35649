class PurchasesAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :purchase, :postcode, :prefecture_id, :city, :address, :building_name, :phone_number

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
end
