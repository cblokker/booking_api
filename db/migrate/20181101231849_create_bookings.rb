class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.references :event, foreign_key: true
      t.references :customer, foreign_key: true

      t.timestamps
    end
  end
end
