class Booking < ApplicationRecord
  belongs_to :event
  belongs_to :customer

  after_create :accept_booking

  enum status: [:creating, :accepted, :canceled, :expired]

  ### TODO: add booking status enum
  def self.active_bookings
    where(status: 1)
  end

  def accept_booking
    update(status: 1)
  end
end
