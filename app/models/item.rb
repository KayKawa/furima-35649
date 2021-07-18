class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  belongs_to :seller, class_name: 'User', foreign_key: 'seller_id'
  belongs_to :buyer, class_name: 'User'
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :cost
  belongs_to :prefecture
  belongs_to :schedule

  # 空の投稿を保存できないようにする
  with_options presence: true do
    validates :image
    validates :name
    validates :content
    # ActiveHashの選択が「--」の時は保存できないようにする
    with_options numericality: { other_than: 1, message: "can't be blank" } do
      validates :category_id
      validates :condition_id
      validates :cost_id
      validates :prefecture_id
      validates :schedule_id
    end
    validates :price
  end
  # 価格の範囲指定
  validates :price, inclusion: { in: 300..9_999_999, message: 'please specify between 300 and 9,999,999.' }
  # 価格は半角数字のみ
  validates :price_before_type_cast, format: { with: /\A[0-9]+\z/, message: 'input half-width characters.' }
end
