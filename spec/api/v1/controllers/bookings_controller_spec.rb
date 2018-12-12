require "rails_helper"


RSpec.describe Api::V1::BookingsController do
  before do
    sign_in(customer)
    headers = {
      "ACCEPT" => "application/json",
      'CONTENT_TYPE' => 'application/json'
    }
  end

  let(:company) do
    Company.create(name: 'name', description: 'desc')
  end

  let(:event) do
    Event.create(company: company)
  end

  let(:customer) do
    Customer.create(first_name: 'first name',
                    last_name: 'last name',
                    email: 'email@email.com',
                    password: 'password')
  end

  describe "GET #index" do
    before do
      get "/events/#{event.id}/bookings", headers: headers
    end

    it "return https success" do
      expect(response).to have_http_status(:success)
    end

    it "returns a specific bookings" do
    end
    
  end

  describe "GET #show" do
    before do
      get "/events/#{event.id}/bookings/#{booking.id}", headers: headers
    end

    it "return https success" do
    end

    it "shows bookings for a specific event" do
    end
  end

  describe "POST #create" do
    before do
      post "/events/#{event.id}/bookings", headers: headers
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "creates a new booking under a current customer for a specific event" do
    end

    ## SHOULD CONTROLLER SPECS TEST FOR THE BELOW? OR SHOULD THIS BE IN MODEL/UNIT TEST?
    it "customer becomes a customer of event's company if it isn't already" do
    end

    it "cannot create a booking if event is not provided" do
    end
  end
end

