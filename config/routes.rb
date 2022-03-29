Rails.application.routes.draw do
  get 'likes/create'
  get 'likes/destroy', to: 'likes#destroy', as: :destroy_like
  devise_for :users, :controllers => {registrations: 'registrations'}
  # resources :tweeets do
  #   resources :likes
  # end

  resources :tweeets do
    get :like, :dislike
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "tweeets#index"
end
