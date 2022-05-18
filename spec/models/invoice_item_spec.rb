require 'rails_helper'

describe InvoiceItem do
  context "relationships" do
    it {should belong_to(:invoice)}
    it {should belong_to(:item)}
    it {should have_one(:merchant).through(:item)}
    it {should have_many(:customers).through(:invoice)}
    it {should have_many(:transactions).through(:invoice)}
  end
end
