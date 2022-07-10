Rails.application.routes.draw do
  resources :developers do
    member do
      post :edit, :show
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "developers#index"
end
