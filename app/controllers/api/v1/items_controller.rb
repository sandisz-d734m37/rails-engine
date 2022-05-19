class Api::V1::ItemsController < ApplicationController
  # def index
  #   @merchant = Merchant.find(params[:merchant_id])
  #   render json: ItemSerializer.new(@merchant.items)
  # end

  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def create
    item = Item.new(item_params)

    if item.save
      render json: ItemSerializer.new(item), status: :created
    else
      render json: item.errors, status: :unprocessable_entity
    end
  end

  def update
    item = Item.find(params[:id])

    item.update(item_params)

    if item.save
      render json: ItemSerializer.new(item)#, status: :updated
    else
      render json: item.errors, status: :bad_request
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
