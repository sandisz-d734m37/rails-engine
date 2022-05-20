class Item < ApplicationRecord
  belongs_to :merchant

  has_many :invoice_items

  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def self.search_by_name(name)
    where('name ILIKE ?', "%#{name.downcase}%").order(:name)
  end

  def self.search_by_min_price(price)
    where('unit_price >= ?', price).order(:name).first
  end

  def self.search_by_max_price(price)
    where('unit_price <= ?', price).order(:name).first
  end
end
