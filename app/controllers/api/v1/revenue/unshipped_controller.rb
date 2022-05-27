class Api::V1::Revenue::UnshippedController < ApplicationController
  def index
    invoices = Invoice.unshipped_revenue(params[:quantity])
    render json: UnshippedOrderSerializer.new(invoices)
  end
end
