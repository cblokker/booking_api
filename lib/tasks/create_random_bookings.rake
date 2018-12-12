namespace :import do
  desc "Create 150 random bookings"
  task random_bookings: :environment do
    150.times do
      random_customer = Customer.limit(1).order("RANDOM()")[0]
      random_event = Event.limit(1).order("RANDOM()")[0]
      random_customer.book!(random_event.id)
    end
  end
end