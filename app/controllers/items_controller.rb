class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
  end

  def new
    @item = Item.new
  end

  private

  def items_params
    params.require(:items).permit(:name, :content, :category_id, :condition_id, :cost_id, :shipping_area_id, :shipping_day_id, :price,
                                  :image).merge(user_id: current_user.id)
  end
end
