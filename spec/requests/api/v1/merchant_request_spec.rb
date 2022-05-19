require 'rails_helper'

describe "Merchants API" do
  context "index" do
    it "Returns all merchants" do
      create_list(:merchant, 3)
      # binding.pry
      get '/api/v1/merchants'

      response_body = JSON.parse(response.body, symbolize_names: true)
      merchants = response_body[:data]

      expect(response).to be_successful
      expect(merchants.count).to eq(3)

      merchants.each do |merch|
        expect(merch).to have_key(:id)
        expect(merch[:id]).to be_a(String)

        expect(merch[:attributes]).to have_key(:name)
        expect(merch[:attributes][:name]).to be_a(String)
      end
    end
  end

  context "show" do
    it "Returns one merchant based on the ID" do
      merchants = create_list(:merchant, 3)

      get "/api/v1/merchants/#{merchants[2].id}"

      response_body = JSON.parse(response.body, symbolize_names: true)
      merchant = response_body[:data]

      expect(response).to be_successful

      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_a(String)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end

    xit "returns 404 when merchant ID doesn't exist" do
      # Ask meg about this!
      # How can we write an RSpec test to expect a 404?
      # This test just returns "Cannot find merchant with ID 400"
      # This is essentially what I want, but I can't figure out how to write
      # it in such a way it will actually pass by telling me that merchant can't be found.
      # create_list(:merchant, 3)

      get '/api/v1/merchants/400'

      response_body = JSON.parse(response.body, symbolize_names: true)

      binding.pry
    end
  end

  context "merchant items index" do
    it "returns a specified merchants items" do
      faker_test_merchants = create_list(:merchant, 3)

      faker_test_merchants[1].items.create!(name: "Item 1", description: "Item 1 Belonging to First Faker Merchant", unit_price: "1.0")
      faker_test_merchants[1].items.create!(name: "Item 2", description: "Item 2 Belonging to First Faker Merchant", unit_price: "2.0")
      faker_test_merchants[2].items.create!(name: "Item 3", description: "Item 3 Belonging to Second Faker Merchant", unit_price: "3.0")

      get "/api/v1/merchants/#{faker_test_merchants[1].id}/items"

      response_body = JSON.parse(response.body, symbolize_names: true)
      items = response_body[:data]

      expect(items.length).to eq(2)
      expect(items[0][:attributes][:name]).to eq("Item 1")
    end
  end
end
