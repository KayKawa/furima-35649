class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_item, only: [:show, :edit, :update]

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
    if @item.user_id == current_user.id # 出品ユーザーと現在のユーザーが同じ
      render :edit
    else
      redirect_to root_path
    end
  end

  def update
    if @item.user_id == current_user.id # 出品ユーザーと現在のユーザーが同じ
      if @item.update(items_params) # 内容の編集ができたら
        redirect_to item_path
      else
        render :edit
      end
    else
      redirect_to root_path
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
end
