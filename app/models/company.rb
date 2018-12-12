class Company < ApplicationRecord
  has_many :company_customers, dependent: :destroy
  has_many :customers, through: :company_customers

  has_many :events, dependent: :destroy
  has_many :bookings, through: :events


  ## find all companies that belong to a specific customer


  ### ACTIVE RECORD / SQL QUERIES ###

  def self.order_by_most_customers
    joins(:customers)
      .group(:id)
      .order('COUNT(customers.id) DESC')
  end

  ### METHODS ###

  def add_customer(customer)
    CompanyCustomer.new(company_id: self, customer: customer).save
  end
end