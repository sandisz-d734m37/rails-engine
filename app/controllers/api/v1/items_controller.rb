class Api::V1::ItemsController < ApplicationController
  before_action :set_item, only: %i[show destroy update]
  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    render json: ItemSerializer.new(@item)
  end

  def create
    item = Item.new(item_params)

    if item.save
      render json: ItemSerializer.new(item), status: :created
    else
      render json: item.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy!
    head :no_content
  end

  def update
    item = Item.find(params[:id])

    item.update(item_params)

    if item.save
      render json: ItemSerializer.new(item)
    else
      render json: item.errors, status: :bad_request
    end
  end

  def find_all
    if !params[:name].blank?
      items = Item.search(params[:name])
      if items.first.nil?
        render json: {
          data:[]
        }, status: 404
      else
        render json: ItemSerializer.multi_item(items), status: :ok
      end
    else
      render json: { error: { message: "Search field can't be blank"} }, status: :bad_request
    end
  end

  def find
    if !params[:name].blank?
      items = Item.search(params[:name])
      if items.first.nil?
        render json: {
          data: {
            message: "Unable to find Item"
          }
        }, status: 404
      else
        render json: ItemSerializer.single_item(items.first)
      end
    else
      render json: {error: {message: "Search field can't be blank"}}, status: 400
    end
  end


  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
