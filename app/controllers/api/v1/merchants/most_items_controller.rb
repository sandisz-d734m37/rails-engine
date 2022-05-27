class Api::V1::Merchants::MostItemsController < ApplicationController
  def index
    merchants = Merchant.top_merchants_by_items_sold(params[:quantity])
    render json: ItemsSoldSerializer.new(merchants)
  end
end
