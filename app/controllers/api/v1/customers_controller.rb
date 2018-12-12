module Api::V1
  class CustomersController < ApplicationController
    # before_action :authenticate_customer!

    # GET /customers
    def index
      @customers = Customer.all
      render json: @customers.as_json, status: :ok
    end

    # GET /customers/:id
    def show
      @customer = Customer.find(params[:id])
      render json: @customer.as_json, status: :ok
    end

    # POST /customers
    def create
      @customer = Customer.new(customer_params)

      if @customer.save
        render json: @customer.as_json, status: :ok
      else
        render json: @customer.errors.as_json, status: :unprocessable_entity
      end
    end

    private

    def customer_params
      params.require(:customer).permit(:first_name, :last_name, :email, :password)
    end
  end
end
