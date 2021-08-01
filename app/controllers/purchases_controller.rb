class PurchasesController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def create
  end

  private

  def purchase_params
    params.permit(item_id: @item.id).merge(user_id: current_user.id)
  end

  def address_params
    params.permit(:postcode, :prefecture_id, :city, :address, :building_name, :phone_number).merge(purchase_id: @purchase.id)
  end
end
