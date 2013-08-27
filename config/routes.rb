Squash::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

root 'bookings#index'

resources :courts
resources :bookings do
  get 'toggle_paid', :on => :member
  resources :time_slots
end
resources :players
resources :sessions


get 'playerlist' => 'players#list', :as => :playerlist
get "log_in" => "sessions#new", :as => "log_in"
get "log_out" => "sessions#destroy", :as => "log_out"
get "sessions/new"

end
