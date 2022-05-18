require "rails_helper"

describe "Items API" do
  context "Index" do
    it "returns all items" do
      # Ask Meg about this!
      # I'm already using the ItemsController Index function for the Merchant Items Index
      # (merchants/:merchant_id/items)
      # Where can I move this action so that I can do a normal Item Index as well as Merchant Items Index?
    end
  end

  context "Show" do
    it "Returns an item specified by ID" do
      faker_test_merchant = create_list(:merchant, 1)
      # faker_test_items = create_list(:item, 3)
      # How can we create a list of items with Faker?
      # I keep getting a "Merchant must exist" error

      item1 = faker_test_merchant[0].items.create!(name: "Item 1", description: "Item 1 Belonging to First Faker Merchant", unit_price: 1.0)
      item2 = faker_test_merchant[0].items.create!(name: "Item 2", description: "Item 2 Belonging to First Faker Merchant", unit_price: 2.0)

      get "/api/v1/items/#{item1.id}"

      response_body = JSON.parse(response.body, symbolize_names: true)
      item = response_body[:data]

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to eq("Item 1")

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to eq("Item 1 Belonging to First Faker Merchant")

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to eq(1.0)
      # expect(item[:attributes][:unit_price]).to eq("1.0")
      # I thought this was supposed to return a string?
    end
  end
end
