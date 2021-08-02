class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_item, only: [:index, :create]
  before_action :unless_move_root, only: [:create]
  before_action :if_move_root, only: [:index]
  before_action :sold_out_item, only: [:index]

  def index
    @purchase_address = PurchaseAddress.new
  end

  def create
    @purchase_address = PurchaseAddress.new(purchase_params)
    if @purchase_address.valid?
      Payjp.api_key = ENV['PAYJP_SECRET_KEY']  # 秘密鍵の環境変数
      Payjp::Charge.create(
        amount: @item.price, # 商品の値段
        card: purchase_params[:token], # カードトークン
        currency: 'jpy' # 通貨の種類（日本円）
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

  def find_item
    @item = Item.find(params[:item_id])
  end

  def unless_move_root
    redirect_to root_path unless @item.user_id == current_user.id # 出品ユーザーと現在のユーザーが同じではない場合
  end

  def if_move_root
    redirect_to root_path if @item.user_id == current_user.id # 出品ユーザーと現在のユーザーが同じ場合
  end

  def sold_out_item
    redirect_to root_path if @item.purchase.present? # 商品が売却済の場合
  end
end
