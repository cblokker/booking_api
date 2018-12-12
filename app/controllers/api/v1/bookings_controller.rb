module Api::V1
  class BookingsController < ApplicationController
    before_action :set_event, only: [:index, :create]
    
    # GET /bookings
    def index
      render json: @event.bookings, status: :ok
    end

    # GET /bookings/:id
    def show
      @booking = Booking.find_by(event: @event, customer: current_customer)
      render json: @booking.as_json, status: :ok
    end

    # POST /bookings
    def create
      current_customer = Customer.first # should be current_customer
      if @booking = current_customer.book!(params[:event_id])
        render json: @booking.as_json, status: :ok
      else
        render json: @booking.errors, status: :unprocessable_entity
      end
    end

    private

    def booking_params
      params.permit(:event_id)
    end

    def set_event
      @event = Event.find(params[:event_id])
    end
  end
end

