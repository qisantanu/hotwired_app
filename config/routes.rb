Rails.application.routes.draw do
  resources :developers do
    member do
      post :edit, :show
    end

    collection do
      get :lists
    end
  end

  resources :notifications, only: [:index] do
    collection do
      get :lists
      post :lists
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'developers#index'
  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  delete '/signout' => 'sessions#destroy'

  resources :blog_posts
end
