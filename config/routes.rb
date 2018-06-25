Rails.application.routes.draw do
  resources :podcasts, only: [:show]
  resources :episodes, only: [:show]

  namespace :admin do
    resources :podcasts do
      member do
        post 'renew_episodes'
      end
    end
  end
end
