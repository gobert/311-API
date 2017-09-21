Rails.application.routes.draw do
  resources :cases, only: %i[index], constraints: { format: 'json' }
end
