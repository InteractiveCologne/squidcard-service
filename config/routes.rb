YAKService::Application.routes.draw do
  devise_for :admins

  root to: "events#index"
  resources :events, except: :show

  match "checkin", to: "events#checkin", as: :event_checkin, via: [:get, :post], defaults: {format: :json}
  post "activate", to: "events#activate", as: :activate_kard, defaults: {format: :json}
end
