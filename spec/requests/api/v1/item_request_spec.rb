require "rails_helper"

describe "Items API" do
  context "Index" do
    it "returns all items" do
      faker_test_merchant = create(:merchant)
      faker_test_items = create_list(:item, 3, {merchant_id: faker_test_merchant.id})
      # I'm already using the ItemsController Index function for the Merchant Items Index
      # (merchants/:merchant_id/items)
      # Where can I move this action so that I can do a normal Item Index as well as Merchant Items Index?
      get "/api/v1/items"

      response_body = JSON.parse(response.body, symbolize_names: true)
      items = response_body[:data]

      expect(items.length).to eq(3)

      items.each do |item|
        expect(item).to have_key(:id)
        expect(item[:id]).to be_a(String)

        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_a(String)

        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to be_a(String)

        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to be_a(Float)
      end
    end
  end

  context "Show" do
    it "Returns an item specified by ID" do

      faker_test_merchant = create(:merchant)
      faker_test_items = create_list(:item, 2, {merchant_id: faker_test_merchant.id})

      get "/api/v1/items/#{faker_test_items[1].id}"

      response_body = JSON.parse(response.body, symbolize_names: true)
      item = response_body[:data]

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)

    end
  end

  context "Create" do
    it "can create an item" do
      faker_test_merchant = create(:merchant)

      post "/api/v1/items", params: {
        item:
        {
         name: "Test Item",
         description: "Test item descricption",
         unit_price: 1.0,
         merchant_id: faker_test_merchant.id
         }
       }

      response_body = JSON.parse(response.body, symbolize_names: true)
      item = response_body[:data]

      expect(item).to have_key(:id)
      expect(item[:id]).to be_a(String)

      expect(item).to have_key(:type)
      expect(item[:type]).to eq("item")

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to eq("Test Item")

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to eq("Test item descricption")

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to eq(1.0)
    end
  end

  context "Update" do
    it "can update an item" do
      faker_test_merchant = create(:merchant)
      faker_test_item = create(:item, {merchant_id: faker_test_merchant.id})

      put "/api/v1/items/#{faker_test_item.id}", params: {
        item:
        {
         name: "Test Item",
         description: "Test item descricption"
         }
       }

      response_body = JSON.parse(response.body, symbolize_names: true)
      item = response_body[:data]

      expect(item).to have_key(:id)
      expect(item[:id]).to be_a(String)

      expect(item).to have_key(:type)
      expect(item[:type]).to eq("item")

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to eq("Test Item")

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to eq("Test item descricption")
    end
  end
end
