class Item < ApplicationRecord
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category, :condition, :cost, :prefecture, :shipping_day

  # 空の投稿を保存できないようにする
  with_options presence: true do
    validates :name
    validates :content
    validates :price,
              numericality: { less_than_or_equal_to: 9_999_999, greater_than_or_equal_to: 300,
                              message: 'Please specify between 300 and 9,999,999.' }
    validates :image
    # ActiveHashの選択が「--」の時は保存できないようにする
    with_options numericality: { other_than: 1, message: "can't be blank" } do
      validates :category_id
      validates :condition_id
      validates :cost_id
      validates :prefecture_id
      validates :shipping_day_id
    end
  end
end
