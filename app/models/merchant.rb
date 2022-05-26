class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def self.search(name)
    where('name ILIKE ?', "%#{name.downcase}%").order(:name)
  end

  def self.top_merchants_by_revenue(quantity)
    # Merchant.invoice_items.joins(:transactions)
    select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) as revenue')
    .joins(invoices: [:invoice_items, :transactions])
    .group(:id)
    .where(transactions: {result: 'success'}, invoices: {status: 'shipped'},)
    .order(revenue: :desc)
    .limit(quantity)
  end

  def self.top_merchants_by_items_sold(quantity = 5)
    select('merchants.*, SUM(invoice_items.quantity) AS item_count')
    .joins(invoices: [:invoice_items, :transactions])
    .group(:id)
    .where(transactions: {result: 'success'}, invoices: {status: 'shipped'})
    .order(item_count: :desc)
    .limit(quantity)
  end

end
