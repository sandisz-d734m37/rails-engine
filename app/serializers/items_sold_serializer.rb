class ItemsSoldSerializer
  include JSONAPI::Serializer
  attributes :name

  attributes :item_count do |merchant|
    merchant.item_count
  end
end
