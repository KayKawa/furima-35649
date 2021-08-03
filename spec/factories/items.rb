FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    content { '商品説明文です。' }
    category_id { rand(2..11) }
    condition_id { rand(2..7) }
    cost_id { rand(2..3) }
    prefecture_id { rand(2..48) }
    schedule_id { rand(2..4) }
    price { rand(300..9_999_999) }
    association :user
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/sample.jpg'), filename: 'sample.jpg')
    end
  end
end
