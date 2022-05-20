class ItemSerializer
  include JSONAPI::Serializer
  attributes :name, :description, :unit_price, :merchant_id

  def self.multi_item(items)
    {
      "data": items.map do |item|
      {
        "id": item.id.to_s,
        "type": 'item',
        "attributes": {
          "name": item.name,
          "description": item.description,
          "unit_price": item.unit_price,
          "merchant_id": item.merchant_id
        }
      }
      end
    }
  end
end
