class ItemsController < ApplicationController
  def index
  end

  private

  def items_params
    params.require(:items).permit(:name, :content, :category_id, :condition_id, :cost_id, :shipping_area_id, :shipping_day_id, :price,
                                  :image).merge(user_id: current_user.id)
  end
end
