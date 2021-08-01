class PurchasesController < ApplicationController
  before_action :authenticate_user!

  def index
    @purchase_address = PurchaseAddress.new
  end

  def create
    @purchase_address = PurchaseAddress.new(purchase_params)
    if @purchase_address.valid?
      @purchase_address.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def purchase_params
    params.require(:purchase_address).permit(:postcode, :prefecture_id, :city, :address, :building_name,
                                             :phone_number, item_id: @item_id).merge(user_id: current_user.id)
  end
end
