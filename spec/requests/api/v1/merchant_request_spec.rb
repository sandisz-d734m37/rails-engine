require 'rails_helper'

describe "Merchants API" do
  context "index" do
    it "Returns all merchants" do
      create_list(:merchant, 3)
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

    it "returns 404 when merchant ID doesn't exist" do
      get '/api/v1/merchants/400'
      expect(response).to have_http_status(404)
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

  describe 'GET api/v1/merchants/find' do

    it 'returns the first merchant matching the search' do
      merchant_1 = Merchant.create!(name: 'B Turing')
      merchant_2 = Merchant.create!(name: 'A The Ring Corp')

      get "/api/v1/merchants/find", params: { name: 'ring' }
      merchant = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(merchant[:type]).to eq('merchant')
      expect(merchant[:id]).to be_a String
      expect(merchant[:attributes][:name]).to eq('A The Ring Corp')
    end

    context 'when it cannot find a merchant' do
      before { get "/api/v1/merchants/find", params: { name: 'NOTAMERCHANT' } }
      it 'returns 404 and an error message' do
        response_data = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(response_data[:message]).to eq("Unable to find Merchant")
        expect(response).to have_http_status(404)
      end
    end

    context 'when the search field is blank' do
      before { get "/api/v1/merchants/find", params: { name: '' } }
      it 'returns 400 and error message' do
        expect(response.body).to match("Search field can't be blank")
        expect(response.status).to eq(400)
      end
    end

  end

  describe 'GET api/v1/merchants/find_all' do
    it 'returns all merchants with case insensitive, partial match' do
      merchant_1 = Merchant.create!(name: 'B Turing')
      merchant_2 = Merchant.create!(name: 'A The Ring Corp')
      merchant_3 = Merchant.create!(name: 'C ne uključuje trgovca prstenovima')

      get "/api/v1/merchants/find_all", params: { name: 'RiNg' }
      merchants = JSON.parse(response.body, symbolize_names: true)[:data]

      merch_name_array = ['A The Ring Corp', 'B Turing']
      merchants.each_with_index do |merchant, index|
        expect(merchant[:type]).to eq('merchant')
        expect(merchant[:id]).to be_a String
        expect(merchant[:attributes][:name]).to eq(merch_name_array[index])
      end
    end

    context 'when it cannot find a merchant' do
      before { get "/api/v1/merchants/find_all", params: { name: 'NOTAMERCHANT' } }
      it 'returns 404 and an empty array' do
        response_data = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(response_data).to be_an(Array)
        expect(response_data.empty?).to be true
      end
    end

    context 'when the search field is blank' do
      before { get "/api/v1/merchants/find_all", params: { name: '' } }
      it 'returns 400 and error message' do
        expect(response.body).to match("Search field can't be blank")
        expect(response.status).to eq(400)
      end
    end
  end
end
