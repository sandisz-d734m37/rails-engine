require 'rails_helper'

describe Merchant do
  context "relationships" do
    it {should have_many(:items)}
    it {should have_many(:invoices)}
    it {should have_many(:invoice_items).through(:invoices)}
    it {should have_many(:customers).through(:invoices)}
    it {should have_many(:transactions).through(:invoices)}
  end

  context "class methods" do
    describe '#search' do
      it 'returns merchants based off their name' do
        merchants = create_list(:merchant, 10)
        name = merchants.first.name

        actual = Merchant.search(name).first
        expected = merchants.first

        expect(actual).to eq(expected)
      end
    end
  end
end
