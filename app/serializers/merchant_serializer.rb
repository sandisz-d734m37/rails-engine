class MerchantSerializer
  include JSONAPI::Serializer
  attributes :name

  def self.single_merchant(merchant)
  {
    "data": {
      "id": merchant.id.to_s,
      "type": 'merchant',
      "attributes": {
        "name": merchant.name
      }
    }
  }
end

  # def self.format_merchants(merchants)
  #   {
  #     data: merchants.map do |merch|
  #       {
  #         id: merch.id,
  #         type: 'merchant',
  #         attributes: {
  #           name: merch.name
  #         }
  #       }
  #     end
  #   }
  # end
end
