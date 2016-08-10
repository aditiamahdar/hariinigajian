Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'home#index'
  post 'fetch-events' => 'home#fetch_events', as: :fetch_events
  delete 'clear-events' => 'home#clear_events', as: :clear_events
end
