require 'rails_helper'

describe "Merchants API" do
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
      expect(merch[:id]).to be_an(Integer)

      expect(merch[:attributes]).to have_key(:name)
      expect(merch[:attributes][:name]).to be_a(String)
    end
  end
end
