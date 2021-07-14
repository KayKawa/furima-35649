require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品の出品登録' do
    context '全項目入力があれば登録できる' do
      it 'name,content,category_id,condition_id,cost_id,prefecture_id,shipping_day_id,priceが存在すれば登録できる' do
        expect(@item).to be_valid
      end
    end
  end
end
