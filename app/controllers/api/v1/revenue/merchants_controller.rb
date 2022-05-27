class Api::V1::Revenue::MerchantsController < ApplicationController
  def index
    merchants = Merchant.top_merchants_by_revenue(params[:quantity])
    render json: MerchantNameRevenueSerializer.new(merchants)
  end

  def show
    merchant = Merchant.find(params[:id])
    render json: MerchantRevenueSerializer.new(merchant)
  end
end
