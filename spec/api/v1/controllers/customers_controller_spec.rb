require "rails_helper"

RSpec.describe Api::V1::CustomersController do
  let!(:customers) { FactoryBot.create_list(:customer, 10) }
  
  describe 'GET api/v1/customers' do
    before do
      host! "localhost:3001"
      get customers_url
    end

    it 'returns HTTP status 200' do
      expect(response).to have_http_status 200
    end

    it 'JSON body returns all customers' do
      body = JSON.parse(response.body)
      expect(body.size).to eq(10)
    end
  end

  describe 'GET api/v1/customers/:id' do
    before do
      host! "localhost:3001"
      get "/customers/#{customers[0].id}"
    end

    it 'returns HTTP status 200' do
      expect(response).to have_http_status 200
    end

    it 'returns the specific customer' do
      body = JSON.parse(response.body)
      expect(body['first_name']).to eq(customers[0]['first_name'])
    end

    it 's' do
      expect(ActiveRecord::Base.connection_config[:database]).to match(/test/)
    end
  end


  describe 'POST api/v1/customers' do
    before do
      host! "localhost:3001"
      post '/customers', params: {
        customer: {
          first_name: 'Chase',
          last_name: 'Blokker',
          email: 'test@test.com',
          password: 'password1234'
        }
      }
    end

    it 'returns HTTP status 200' do
      expect(response).to have_http_status 200
    end

    it 'creates a new customer' do
      body = JSON.parse(response.body)
      expect(Customer.all.size).to eq(11)
    end
  end
end

# general controller test practice
# - test for status of sucess
# get - test size is +1
# get index
# test body size returns all
# test