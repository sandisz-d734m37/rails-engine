require 'rails_helper'

describe Item do
  context "relationships" do
    it {should belong_to(:merchant)}
    it {should have_many(:invoice_items)}
    it {should have_many(:invoices).through(:invoice_items)}
    it {should have_many(:customers).through(:invoices)}
    it {should have_many(:transactions).through(:invoices)}
  end
end
