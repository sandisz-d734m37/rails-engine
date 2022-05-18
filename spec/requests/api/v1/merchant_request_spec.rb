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
      create_list(:merchant, 3)
      # binding.pry
      get '/api/v1/merchants/4'

      response_body = JSON.parse(response.body, symbolize_names: true)
      merchant = response_body[:data]
      # binding.pry
      expect(response).to be_successful

      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to eq("4")

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end
end
