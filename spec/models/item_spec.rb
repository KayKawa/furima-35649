require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品の出品登録' do
    context '出品ができる時' do
      it '全項目入力があれば登録できる' do
        expect(@item).to be_valid
      end
      it 'priceが半角数字かつ300~9999999の範囲であれば登録できる' do
        expect(@item).to be_valid
      end
    end
    context '出品ができない時' do
      it 'nameが空では登録できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it 'contentが空では登録できない' do
        @item.content = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Content can't be blank")
      end
      it 'category_idが空では登録できない' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it 'condition_idが空では登録できない' do
        @item.condition_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end
      it 'cost_idが空では登録できない' do
        @item.cost_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Cost can't be blank")
      end
      it 'prefecture_idが空では登録できない' do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'shipping_day_idが空では登録できない' do
        @item.shipping_day_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping day can't be blank")
      end
      it 'priceが空では登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it 'priceが全角数字では登録できない' do
        @item.price = '１１１１'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price before type cast input half-width characters.')
      end
      it 'priceが半角数字以外が混ざっていると登録できない' do
        @item.price = '111aaa'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price before type cast input half-width characters.')
      end
      it 'priceが英字では登録できない' do
        @item.price = 'hoge'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price before type cast input half-width characters.')
      end
      it 'priceがひらがなでは登録できない' do
        @item.price = 'ほげ'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price before type cast input half-width characters.')
      end
      it 'category_idが"--"選択では登録できない' do
        @item.category_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it 'condition_idが"--"選択では登録できない' do
        @item.condition_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end
      it 'cost_idが"--"選択では登録できない' do
        @item.cost_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Cost can't be blank")
      end
      it 'prefecture_idが"--"選択では登録できない' do
        @item.prefecture_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'shipping_day_idが"--"選択では登録できない' do
        @item.shipping_day_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping day can't be blank")
      end
      it 'priceが299円以下では登録できない' do
        @item.price = rand(1..299)
        @item.valid?
        expect(@item.errors.full_messages).to include('Price please specify between 300 and 9,999,999.')
      end
      it 'priceが10,000,000以上では登録できない' do
        @item.price = '100000000000'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price please specify between 300 and 9,999,999.')
      end
    end
  end
end
