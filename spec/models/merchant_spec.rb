require 'rails_helper'

describe Merchant do
  context "relationships" do
    it {should have_many(:items)}
    it {should have_many(:invoices)}
    it {should have_many(:invoice_items).through(:invoices)}
    it {should have_many(:customers).through(:invoices)}
    it {should have_many(:transactions).through(:invoices)}
  end
end
