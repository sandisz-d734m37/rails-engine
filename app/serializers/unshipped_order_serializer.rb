class UnshippedOrderSerializer
  include JSONAPI::Serializer
  attributes :potential_revenue do |invoice|
    invoice.potential_revenue
  end
end
