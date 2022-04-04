Rails.application.routes.draw do
  get 'profile_users/:id', to: 'profile_users#show'
  get 'likes/create'
  get 'likes/destroy', to: 'likes#destroy', as: :destroy_like
  devise_for :users, :controllers => {registrations: 'registrations'}

  post '/profile_users/:id/create_follow', to: "profile_users#create_follow", as: :create_follow
  post '/profile_users/:id/destroy_follow', to: "profile_users#destroy_follow", as: :destroy_follow
  
  resources :profile_users
  get '/profile_users/:id/follower', to: "profile_users#follower", as: :follower
  post '/profile_users/:id/follower', to: "profile_users#follower"

  post '/profile_users/:id/following', to: "profile_users#following", as: :following
  
  # resources :tweeets do
  #   resources :likes
  # end
  
  resources :tweeets do
    get :like, :dislike
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "tweeets#index"
end
