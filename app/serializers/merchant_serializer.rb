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

  def self.multi_merchant(merchants)
    {
      "data": merchants.map do |merchant|
        {
          "id": merchant.id.to_s,
          "type": 'merchant',
          "attributes": {
            "name": merchant.name
          }
        }
      end
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
