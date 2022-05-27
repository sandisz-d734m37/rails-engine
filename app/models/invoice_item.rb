class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item

  has_one :merchant, through: :item

  has_many :transactions, through: :invoice
  has_many :customers, through: :invoice

  def self.total_sales_for(start_date, end_date)
    select(`SUM(invoice_items.quantity * invoice_items.unit_price) as revenue`).joins(invoices: :transactions).where("transactions.result = success AND incoives.status = shipped AND invoice_items.created_at BETWEEN ``#{start_date} 00:00:00` AND invoice_items.updated_at > ``#{end_date} 00:00:00").group(:id)
  end
end
