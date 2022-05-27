class Item < ApplicationRecord
  belongs_to :merchant

  has_many :invoice_items

  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def self.search(name)
    where('name ILIKE ?', "%#{name.downcase}%").order(:name)
  end

  def self.top_items_by_revenue(quantity = 10)
    select("items.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .joins(invoice_items: [:invoice, :transactions])
    .group(:id)
    .where(transactions: {result: "success"}, invoices: {status: "shipped"})
    .order(revenue: :desc)
    .limit(quantity)
  end
end
