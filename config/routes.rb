Rails.application.routes.draw do
  namespace :admin do
    resources :podcasts
  end
end
