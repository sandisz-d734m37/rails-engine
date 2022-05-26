class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def self.search(name)
    where('name ILIKE ?', "%#{name.downcase}%").order(:name)
  end

  def self.top_merchants_by_revenue(number)
    # Merchant.invoice_items.joins(:transactions)
    joins(invoice_items: [:invoices, :transactions])
  end
end
