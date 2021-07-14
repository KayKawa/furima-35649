class Item < ApplicationRecord
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category, :condition, :cost, :prefecture, :shipping_day

  # 空の投稿を保存できないようにする
  with_options presence: true do
    validates :name
    validates :content
    validates :price, numericality: { in: 300..9_999_999, message: 'Please specify between 300 and 9,999,999.' }
    validates :image
    # ActiveHashの選択が「--」の時は保存できないようにする
    with_options numericality: { other_than: 1 } do
      validates :category_id, { message: "Category can't be blank" }
      validates :condition_id, { message: "Condition can't be blank" }
      validates :cost_id, { message: "Cost can't be blank" }
      validates :prefecture_id, { message: "Predecture can't be blank" }
      validates :shipping_day_id, { message: "Shipping_day can't be blank" }
    end
  end
end
