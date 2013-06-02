SquidcardService::Application.routes.draw do
  match "checkin", to: "events#checkin", as: :event_checkin, via: [:get, :post], defaults: {format: :json}
end
