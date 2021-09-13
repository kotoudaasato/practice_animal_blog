Rails.application.routes.draw do


  scope module: :public do
    root to: 'homes#top'
    devise_for :users
      resources :users
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
