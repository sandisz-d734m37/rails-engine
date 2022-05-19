require "rails_helper"

describe "Items API" do
  context "Index" do
    it "returns all items" do
      faker_test_merchant = create(:merchant)
      faker_test_items = create_list(:item, 3, {merchant_id: faker_test_merchant.id})

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

  context "Delete" do
    it "can delete an item" do
      faker_test_merchant = create(:merchant)
      faker_test_item = create(:item, {merchant_id: faker_test_merchant.id})

      delete "/api/v1/items/#{faker_test_item.id}"


      expect(response).to have_http_status(204)
    end
  end

  context "Items/:id/Merchant" do
    it "returns a merchant" do
      faker_test_merchant = create(:merchant)
      faker_test_item = create(:item, {merchant_id: faker_test_merchant.id})

      get "/api/v1/items/#{faker_test_item.id}/merchant"
      expect(response).to have_http_status(200)

      response_body = JSON.parse(response.body, symbolize_names: true)
      merchant = response_body[:data]


      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_a(String)

      expect(merchant).to have_key(:type)
      expect(merchant[:type]).to eq("merchant")

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

  describe 'GET api/v1/items/find_all' do

    it 'returns the first merchant matching the search' do
      faker_test_merchant = create(:merchant)
      item_1 = Item.create!(name: 'B Gold Ring', description: "This should be found", unit_price: 35.00, merchant_id: faker_test_merchant.id)
      item_2 = Item.create!(name: 'A Silver Ring', description: "This too", unit_price: 35.00, merchant_id: faker_test_merchant.id)
      item_3 = Item.create!(name: 'C Macaroni and Cheese', description: "Not this tho", unit_price: 35.00, merchant_id: faker_test_merchant.id)

      get "/api/v1/items/find_all", params: { name: 'ring' }

      items = JSON.parse(response.body, symbolize_names: true)[:data]
      items.each do |item|
        expect(item[:type]).to eq('item')
        expect(item[:id]).to be_a String
        expect(item[:attributes][:name]).to eq('A The Ring Corp')
      end
    end

    context 'when it cannot find an item' do
      before { get "/api/v1/items/find_all", params: { name: 'NOITEMHASTHISNAME' } }
      it 'returns 404 and error message' do
        response_data = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(response_data[:message]).to eq("Unable to find Items")
        expect(response).to have_http_status(404)
      end
    end

    context 'when the search field is blank' do
      before { get "/api/v1/items/find_all", params: { name: '' } }
      it 'returns 400 and error message' do
        expect(response.body).to match("Search field can't be blank")
        expect(response.status).to eq(400)
      end
    end

  end
end
