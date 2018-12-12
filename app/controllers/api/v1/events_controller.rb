module Api::V1
  class EventsController < ApiController
    # before_action :authenticate_user!
    before_action :set_company, only: [:index]
    
    # GET /events
    def index
      @events = @company.try(:events).as_json(methods: [:has_customer_booked, :current_availability]) ||
                Event.all.as_json(methods: [:company_name, :current_availability])
      render json: @events, status: :ok
    end

    # GET /events/:id
    def show
      @event = Event.find(params[:id])
      render json: @event.as_json, status: :ok
    end

    # POST /events
    def create
      @event = Event.new(customer_params)

      if @event.save
        render json: @event.as_json, status: :ok
      else
        render json: @event.errors.as_json, status: :unprocessable_entity
      end
    end

    private

    def set_company
      @company = Company.find(params[:company_id]) if params[:company_id]
    end
  end
end
