class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :company_customers, dependent: :destroy
  has_many :companies, through: :company_customers

  has_many :bookings, dependent: :destroy
  has_many :events, through: :bookings

  # we can dry this up by collecting Event.category_type and using define method to
  # create all expected scopes
  scope :with_events_booked_of_type, -> (booking_type) do
    joins(bookings: :event).
    where(events: {category: booking_type }).
    uniq
  end

  scope :with_events_booked_more_than_one_type, -> (booking_type) do
    joins(bookings: :event).
    where(events: {category: booking_type }).
    group('customers.id').
    having('COUNT(*) > 1')
  end

  scope :customers_with_the_most_bookings, -> do
    joins(:bookings).
    group(:id).
    order('COUNT(bookings.id) DESC').
    limit(10)
  end

  # time related things

  ## find all customers that have booked yoga events (scopes)
  # def self.booking_type
  #   Customer.joins(bookings: :event).where(event: {category: 'yoga' })
  # end

  ### VALIDATIONS ###
  validates :first_name, presence: true


  ### THINK OF EXTRACTING OUT INTO A BOOKABLE CLASS/MODULE

  ### METHODS ###
  def book!(event_id)
    event = Event.find(event_id)
    become_customer_of(event.company_id)
    Booking.new(event: event, customer: self).save # validations on model and database will prevent customer booking same event twice
  end

  def become_customer_of(company_id)
    # validations on model and database will prevent becoming customer of company twice
    CompanyCustomer.new(company_id: company_id, customer: self).save
  end
end
