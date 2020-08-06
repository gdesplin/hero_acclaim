Rails.application.routes.draw do
  resources :acclaims
  resources :heroes
  root :to => "heroes#index"
end
