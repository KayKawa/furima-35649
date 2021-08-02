require 'rails_helper'

RSpec.describe PurchaseAddress, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @purchase_address = FactoryBot.build(:purchase_address, user_id: @user.id, item_id: @item.id)
    sleep 0.1
  end

  describe '商品購入' do
    context '商品の購入ができる時' do
      it '必要な情報を適切に入力すると配送先の登録ができて、商品の購入ができる' do
        expect(@purchase_address).to be_valid
      end
      it '郵便番号にハイフンを正しく入力すると配送先の登録ができて、商品の購入ができる' do
        @purchase_address.token = '999-9999'
        expect(@purchase_address).to be_valid
      end
      it '都道府県に"--"以外を選択すると配送先の登録ができて、商品の購入ができる' do
        @purchase_address.prefecture_id = 47
        expect(@purchase_address).to be_valid
      end
      it '電話番号を半角数字で正しく入力すると配送先の登録ができて、商品の購入ができる' do
        @purchase_address.phone_number = '09011112222'
        expect(@purchase_address).to be_valid
      end
      it '電話番号を半角数字10桁で入力すると配送先の登録ができて、商品の購入ができる' do
        @purchase_address.phone_number = '1234567890'
        expect(@purchase_address).to be_valid
      end
    end
    context '商品の購入ができない時' do
      it 'クレジットカード情報は必須であり、正しいクレジットカードの情報で無いときは、購入できない' do
        @purchase_address.token = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Token can't be blank")
      end
      it '郵便番号にハイフンがないと配送先の登録ができず、購入できない' do
        @purchase_address.postcode = '1234567'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Postcode is invalid. Enter it as follows (e.g. 123-4567)')
      end
      it '電話番号が11桁より少ないと配送先の登録ができず、購入できない' do
        @purchase_address.phone_number = '12345'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Phone number is too short')
      end
      it '電話番号が全角数字だと配送先の登録ができず、購入できない' do
        @purchase_address.phone_number = '１２３４５６７８９１０'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Phone number is invalid.Input only half-width number')
      end
      it '電話番号が全角文字だと配送先の登録ができず、購入できない' do
        @purchase_address.phone_number = '電話番号'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Phone number is invalid.Input only half-width number')
      end
      it '電話番号が半角英字だと配送先の登録ができず、購入できない' do
        @purchase_address.phone_number = 'phonenumber'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Phone number is invalid.Input only half-width number')
      end
      it '郵便番号が空白だと配送先の登録ができず、購入できない' do
        @purchase_address.postcode = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Postcode can't be blank")
      end
      it '都道府県が"--"だと配送先の登録ができず、購入できない' do
        @purchase_address.prefecture_id = '1'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '市区町村が空白だと配送先の登録ができず、購入できない' do
        @purchase_address.city = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("City can't be blank")
      end
      it '番地が空白だと配送先の登録ができず、購入できない' do
        @purchase_address.address = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Address can't be blank")
      end
      it '電話番号が空白だと配送先の登録ができず、購入できない' do
        @purchase_address.phone_number = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number can't be blank")
      end
    end
  end
end
