class RevenueByDateSerializer
  include JSONAPI::Serializer
  # binding.pry
  # attributes :revenue do |object|
  #   object.total
  # end
  def self.revenue(revenue)
    {
      "data": {
        "id": nil,
        "type": 'revenue',
        "attributes": {
          "revenue": revenue
        }
      }
    }
  end
end
