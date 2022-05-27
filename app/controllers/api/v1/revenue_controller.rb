class Api::V1::RevenueController < ApplicationController
  def index
      revenue = Invoice.total_sales_for(params[:start], params[:end])
      render json: RevenueByDateSerializer.revenue(revenue)
  end
end
