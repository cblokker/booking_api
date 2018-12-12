class Event < ApplicationRecord
  belongs_to :company

  has_many :bookings
  has_many :customers, through: :bookings

  delegate :add_customer, to: :company
  delegate :name, to: :company, prefix: true

  attr_accessor :current_cusomter

  LIST_OF_CATEGORIES = ['yoga', 'fitness', 'spa']


  ### METHODS ###

  def be_booked_by!(customer)
    event.add_customer(customer)
    CompanyCustomer.new(company_id: self.company_id, customer: customer).save
    # check availability / capacity
  end

  def schedule
    # schedule = IceCube::Schedule.new(now = start_date)
    # schedule.add_recurrence_rule IceCube::Rule.weekly(2)
  end

  def has_customer_booked(customer = nil)
    customer = Customer.first
    Booking.exists?(event: self, customer: customer)
  end

  def current_availability
    self.capacity - current_filled_slots
  end

  def current_filled_slots
    bookings.where(status: :accepted).count
  end


  ### RECCURING EVENT MANAGEMENT ###
  ## input
  ## daily: {:monday, :tuesday, :thursday, :friday, }
  ## this_week: {:tuesd}
  ## next_week: {}
  ## multi day (hourly)
  # def create_recurring_event(frequency)
  #   case frequency
  #   when :daily
  #     self.add_recurrence_rule(IceCube::Rule.daily)
  #   when :weekday
  #     self.add_recurrence_rule(IceCube::Rule.daily.day(:monday, :tuesday, :wednesday, :thursday, :friday)
  #   when :weekend
  #     self.add_recurrence_rule(IceCube::Rule.daily)
  #   end
  # end

  # TODO: Add event availability, capacity, scheduling, and recurring events
end
