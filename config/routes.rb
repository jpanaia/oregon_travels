Rails.application.routes.draw do
  devise_for :users

  resources :comments
  resources :photos
  resources :blog_posts

  root "blog_posts#index"
  get "allusers" => "blog_posts#showusers"

end
