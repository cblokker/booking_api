module Api::V1
  class CompaniesController < ApplicationController
    # before_action :authenticate_user!
    
    # GET /companies
    def index
      @companies = Company.all
      render json: @companies.as_json, status: :ok
    end

    # GET /companies/:id
    def show
      @company = Company.find(params[:id])
    end

    # POST /companies
    def create
      @company = Company.new(company_params)

      if @company.save
        render json: @company.as_json, status: :ok
      else
        render json: @company.as_json, status: :unprocessable_entity
      end
    end

    private

    def company_params
      params.require(:company).permit(:name, :description, :category)
    end
  end
end
