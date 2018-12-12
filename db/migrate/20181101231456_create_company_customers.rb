class CreateCompanyCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :company_customers do |t|
      t.references :company, foreign_key: true, unique: true
      t.references :customer, foreign_key: true, unique: true

      t.timestamps
    end
  end
end
