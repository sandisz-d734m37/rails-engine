class Api::V1::MerchantsController < ApplicationController

  def index
    render json: MerchantSerializer.format_merchants(Merchant.all), status: :ok
    # render json: MerchantsSerializer.format_merchants(Merchant.all), status: :ok
  end

end
