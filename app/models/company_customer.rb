class CompanyCustomer < ApplicationRecord
  belongs_to :company
  belongs_to :customer

  validates_uniqueness_of :company_id, scope: :customer_id
end
