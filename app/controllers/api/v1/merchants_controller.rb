class Api::V1::MerchantsController < ApplicationController

  def index
    render json: MerchantSerializer.new(Merchant.all)#, status: :ok
  end

  def show
    if Merchant.where(id: params[:id]).empty?
      render json: {
          error: "No such merchant; check the entered ID",
          status: 404
        }, status: 404
    else
      render json: MerchantSerializer.new(Merchant.find(params[:id]))#, status: :ok
    end
  end
end
