class PurchasesController < ApplicationController
  before_action :authenticate_user!

  def index
    @item = Item.find(params[:item_id])
    @purchase_address = PurchaseAddress.new
  end

  def create
    @item = Item.find(params[:item_id])
    @purchase_address = PurchaseAddress.new(purchase_params)
    if @purchase_address.valid?
      Payjp.api_key = ENV['PAYJP_SECRET_KEY']  # 秘密鍵
      Payjp::Charge.create(
        amount: @item.price, # 商品の値段
        card: purchase_params[:token], # カードトークン
        currency: 'jpy'                 # 通貨の種類（日本円）
      )
      @purchase_address.save
      redirect_to root_path
    else
      render action: :index
    end
  end

  private

  def purchase_params
    params.require(:purchase_address).permit(:purchase_id, :postcode, :prefecture_id, :city, :address, :building_name,
                                             :phone_number).merge(token: params[:token], item_id: params[:item_id], user_id: current_user.id)
  end
end
