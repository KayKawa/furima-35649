FactoryBot.define do
  factory :purchase_address do
    postcode { '123-0000' }
    prefecture_id { rand(2..48) }
    city { Gimei.city.kanji }
    address { Gimei.town.kanji }
    building_name { '' }
    phone_number { Faker::Number.number(digits: 11) }
    token { 'tok_abcdefghijk22222222222222222' }
    user_id { @user.id }
    item_id { @item.id }
    association :user  # users.rbのFactoryBotとアソシエーション
    association :item  # items.rbのFactoryBotとアソシエーション
  end
end
