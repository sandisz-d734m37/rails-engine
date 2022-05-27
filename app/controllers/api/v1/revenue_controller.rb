class Api::V1::RevenueController < ApplicationController
  def index
      total = Invoice.total_sales_for(params[:start], params[:end])
      # total
      # binding.pry
      revenue = total.first
      render json: RevenueByDateSerializer.revenue_by_date(revenue)

  end
end
