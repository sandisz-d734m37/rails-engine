class Api::V1::MerchantItemsController < ApplicationController
  def index
    if Merchant.where(id: params[:merchant_id]).empty?
      render json: {
          error: "No such merchant; check the entered ID",
          status: 404
        }, status: 404
    else
      @merchant = Merchant.find(params[:merchant_id])
      render json: ItemSerializer.new(@merchant.items)
    end
  end

  def show
    if Item.where(id: params[:item_id]).empty?
      render json: {
          error: "No such item; check the entered ID",
          status: 404
        }, status: 404
    else
      @item = Item.find(params[:item_id])
      render json: MerchantSerializer.new(@item.merchant)
    end
  end
end
