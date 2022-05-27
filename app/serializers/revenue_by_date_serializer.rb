class RevenueByDateSerializer
  include JSONAPI::Serializer

  def self.revenue_by_date(revenue)
    {
      "data": {
        "id": nil,
        "attributes": {
          "revenue": revenue.revenue
        }
      }
    }
  end
end
