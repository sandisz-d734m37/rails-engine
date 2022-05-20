require 'rails_helper'

describe Item do
  context "relationships" do
    it {should belong_to(:merchant)}
    it {should have_many(:invoice_items)}
    it {should have_many(:invoices).through(:invoice_items)}
    it {should have_many(:customers).through(:invoices)}
    it {should have_many(:transactions).through(:invoices)}
  end

  context "class methods" do
    describe '#search_by_name' do
      it 'returns multiple items' do
        faker_test_merchant = create(:merchant)
        item_1 = Item.create!(name: 'B Gold Ring', description: "This should be found", unit_price: 35.00, merchant_id: faker_test_merchant.id)
        item_2 = Item.create!(name: 'A Silver Ring', description: "This too", unit_price: 35.00, merchant_id: faker_test_merchant.id)
        item_3 = Item.create!(name: 'C Macaroni and Cheese', description: "Not this tho", unit_price: 35.00, merchant_id: faker_test_merchant.id)

        search = Item.search_by_name('ring')

        expect(search).to include(item_1)
        expect(search).to include(item_2)
      end
    end

    describe '#search_by_min_price' do
      it 'returns one item' do
        faker_test_merchant = create(:merchant)
        item_1 = Item.create!(name: 'B Gold Ring', description: "This should be found", unit_price: 35.00, merchant_id: faker_test_merchant.id)
        item_2 = Item.create!(name: 'A Silver Ring', description: "This too", unit_price: 55.00, merchant_id: faker_test_merchant.id)
        item_3 = Item.create!(name: 'C Macaroni and Cheese', description: "Not this tho", unit_price: 51.00, merchant_id: faker_test_merchant.id)

        search = Item.search_by_min_price(50)

        expect(search).to eq(item_2)
      end
    end

    describe '#search_by_max_price' do
      it 'returns one item' do
        faker_test_merchant = create(:merchant)
        item_1 = Item.create!(name: 'B Gold Ring', description: "This should be found", unit_price: 35.00, merchant_id: faker_test_merchant.id)
        item_2 = Item.create!(name: 'A Silver Ring', description: "This too", unit_price: 34.00, merchant_id: faker_test_merchant.id)
        item_3 = Item.create!(name: 'C Macaroni and Cheese', description: "Not this tho", unit_price: 33.00, merchant_id: faker_test_merchant.id)

        search = Item.search_by_max_price(50)

        expect(search).to eq(item_2)
      end
    end
  end
end
