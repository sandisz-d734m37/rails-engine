class MerchantSerializer
  include JSONAPI::Serializer
  attributes :name

  def self.format_merchants(merchants)
    {
      data: merchants.map do |merch|
        {
          id: merch.id,
          type: 'merchant',
          attributes: {
            name: merch.name
          }
        }
      end
    }
  end
end
