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
    resources :users
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
