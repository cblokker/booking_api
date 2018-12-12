require 'rails_helper'

# Test suite for User model
RSpec.describe Customer, type: :model do
  it { should have_many(:bookings) }
  it { should validate_presence_of(:first_name) }
end