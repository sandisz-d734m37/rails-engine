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

  def find
    if !params[:name].blank?
      merchant = Merchant.search(params[:name]).first
      if merchant.nil?
        render json: {
          data: { message: 'Unable to find Merchant' }
        }, status: 404
      else
        render json: MerchantSerializer.single_merchant(merchant), status: :ok
      end
    else
      render json: { error: { message: "Search field can't be blank'" } }, status: :bad_request
    end
  end
end
