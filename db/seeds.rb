require 'factory_bot'


CompanyCustomer.destroy_all
Customer.destroy_all
Company.destroy_all
Event.destroy_all
Booking.destroy_all

100.times do |i|
  c = Customer.create!(
    first_name: "Customer-#{i}",
    last_name: "Last Name-#{i}",
    email: "test_email_#{i}@gmail.com",
    password: "password_#{i}",
    password_confirmation: "password_#{i}",
  )
end


10.times do |i|
  c = Company.create(
    name: "Company-#{i}",
    description: "This is a description of the company. It's a botique company that offers #{i} for its users",
    category: ['yoga', 'fitness', 'spa'].sample
  )

  rand(6).times do |i|
    Event.create(
      company: c,
      category: ['yoga', 'fitness', 'spa'].sample, # sub categories of company category
      capacity: rand(10..50)
    )
  end
end




