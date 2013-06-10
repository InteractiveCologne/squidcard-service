YAKService::Application.routes.draw do
  devise_for :admins

  root to: "events#index"
  resources :events, except: :show

  match "checkin", to: "events#checkin", as: :event_checkin, via: [:get, :post], defaults: {format: :json}
end
