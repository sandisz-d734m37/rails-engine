class Api::V1::MerchantsController < ApplicationController

  def index
    render json: MerchantSerializer.new(Merchant.all)#, status: :ok
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))#, status: :ok
    # merchant = Merchant.find(params[:id])
    # binding.pry
    # if Merchant.where(id: params[:id]).empty?
    #   render json: merchant.errors, status: :not_found
    # else
      # render json: MerchantSerializer.new(Merchant.find(params[:id]))#, status: :ok
    # end
  end
end
