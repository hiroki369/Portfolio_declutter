Rails.application.routes.draw do


devise_for :admins, controllers: {
  sessions:      'admins/sessions',
  passwords:     'admins/passwords',
  registrations: 'admins/registrations'
}
devise_for :users, controllers: {
  sessions:      'users/sessions',
  passwords:     'users/passwords',
  registrations: 'users/registrations'
}

 root to: "posts#index"

 resources :users
 resources :posts do
  resource :favorites, only: [:create, :destroy]
	resources :post_comments do
	get 'best_answer', to: 'posts#best_answer', :as => :post_best_answer
	patch 'best_answer', to: 'post_comments#authorize_best_answer'
    end
 end

resources :relationships, only: [:create, :destroy]
get '/users/:id/follow/', to: 'users#follow', :as => :user_follow
get '/users/:id/follower/', to: 'users#follower', :as => :user_follower

end
