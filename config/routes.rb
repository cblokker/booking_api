Rails.application.routes.draw do
  scope module: 'api', defaults: { format: :json } do
    scope module: 'v1' do
      resources :customers
      devise_for :customers, controllers: {
        registrations: 'api/v1/customers_controller/registrations'
      }
      
      resources :events, only: [:index, :show, :new, :create] do
        resources :bookings, only: [:index, :show, :new, :create]
      end

      authenticated do
        root to: "secret#index", as: :authenticated_root
      end

      root to: "home#index"

      resources :companies do
        resources :events
      end

      resources :events
    end
  end
end
