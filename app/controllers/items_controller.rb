class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
  end

  def new
    @item = Item.new
  end

  def create
    item = Item.create(items_params)
    if item
      render :index
    else
      redirect_to :new_item_path
    end
  end

  private

  def items_params
    params.require(:item).permit(:name, :content, :category_id, :condition_id, :cost_id, :prefecture_id, :shipping_day_id, :price,
                                 :image).merge(user_id: current_user.id)
  end
end
