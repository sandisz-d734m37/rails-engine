class Item < ApplicationRecord
  belongs_to :merchant

  has_many :invoice_items

  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def self.search(name)
    where('name ILIKE ?', "%#{name.downcase}%").order(:name)
  end
end
