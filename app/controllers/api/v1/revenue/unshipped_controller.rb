class Api::V1::Revenue::UnshippedController
  def index
    invoices = Invoice.unshipped_revenue(params[:quantity])
    render json: UnshippedOrderSerializer.new(invoices)
  end
end
