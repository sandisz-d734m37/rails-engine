class Api::V1::Revenue::ItemsController < ApplicationController
 def index
   if params[:quantity].nil?
     items = Item.top_items_by_revenue(10)
     render json: ItemRevenueSerializer.new(items)
   elsif params[:quantity].to_i > 0
     items = Item.top_items_by_revenue(params[:quantity])
     render json: ItemRevenueSerializer.new(items)
   else
     render json: {
       data: { message: 'Error' }
     }, status: 400
   end
 end
end
