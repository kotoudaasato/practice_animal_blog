Rails.application.routes.draw do

devise_for :admins, controllers: {
    sessions: 'admins/sessions'
  }
  scope module: :public do
    root to: 'homes#top'
    devise_for :users, controllers: {
      registrations: 'public/users/registrations',
      sessions: 'public/users/sessions'

    }
    resources :users do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end
    get "search_tag"=>"posts#search_tag"
    resources :posts do
      resources :post_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
    resources :notifications, only: [:index]

  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
