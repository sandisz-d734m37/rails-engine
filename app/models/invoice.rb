class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant

  has_many :transactions
  has_many :invoice_items

  has_many :items, through: :invoice_items

  def self.total_sales_for(start_date, end_date)
    select('SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
    .joins(:transactions, :invoice_items)
    .where("transactions.result = 'success' AND invoices.status = 'shipped' AND invoices.updated_at BETWEEN '#{start_date} 00:00:00' AND '#{end_date} 00:00:00'")
    .limit(1)
    # select('SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue').joins(:transactions, :invoice_items).where("transactions.result = 'success' AND invoices.status = 'shipped' AND invoice_items.created_at BETWEEN '2000-03-09 00:00:00' AND '2022-03-24 00:00:00'")
  end
end
