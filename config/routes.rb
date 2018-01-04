Rails.application.routes.draw do
  get 'podcasts/:id', to: 'podcasts#show'

  namespace :admin do
    resources :podcasts
  end
end
