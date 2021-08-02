class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_item, only: [:show, :edit, :update, :destroy]
  before_action :find_purchase, only: [:index, :show]
  before_action :move_to_root, only: [:edit, :update]
  before_action :sold_out_item, only: [:edit, :destroy]

  def index
    @items = Item.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(items_params)

    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(items_params) # 内容の編集ができたら
      redirect_to item_path
    else
      render :edit
    end
  end

  def destroy
    if @item.user_id == current_user.id
      @item.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  private

  def items_params
    params.require(:item).permit(:name, :content, :category_id, :condition_id, :cost_id, :prefecture_id, :schedule_id, :price,
                                 :image).merge(user_id: current_user.id)
  end

  def find_item
    @item = Item.find(params[:id])
  end

  def find_purchase
    @purchase = Purchase.pluck(:item_id) # Purchaseモデルからitem_idのカラムを取得し配列で返す
  end

  def move_to_root
    redirect_to root_path unless @item.user_id == current_user.id # 出品ユーザーと現在のユーザーが同じではない場合
  end

  def sold_out_item
    @purchase = Purchase.pluck(:item_id) # Purchaseモデルからitem_idのカラムを取得し配列で返す
    redirect_to root_path if @purchase.include?(@item.id) # 購入記録のitem_idカラム配列に該当商品のidが含まれてる＝売約済
  end
end
