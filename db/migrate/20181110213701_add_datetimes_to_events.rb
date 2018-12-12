class AddDatetimesToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :start_at, :datetime
    add_column :events, :end_at, :datetime
    add_column :events, :capacity, :integer
    add_column :bookings, :status, :integer
    add_index :bookings, :status
  end
end
