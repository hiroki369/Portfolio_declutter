Rails.application.routes.draw do


devise_for :admins, controllers: {
  sessions:      'admins/sessions',
  passwords:     'admins/passwords',
  registrations: 'admins/registrations'
}
devise_for :users, controllers: {
  sessions:      'users/sessions',
  passwords:     'users/passwords',
  registrations: 'users/registrations',
  omniauth_callbacks: 'users/omniauth_callbacks'
}

namespace  :admins do
  get '/', to: 'users#top'
  get '/users/', to: 'users#index'
  get '/users/:id/', to: 'users#show', :as => :users_show
  get '/users/:id/edit', to: 'users#edit', :as => :users_edit
  patch '/users/:id/', to: 'users#update', :as => :users_update
  get '/posts/', to: 'posts#index'
  get '/posts/:id/', to: 'posts#show', :as => :posts_show
  get '/posts/:id/edit', to: 'posts#edit', :as => :posts_edit
  patch '/posts/:id/', to: 'posts#update', :as => :posts_update
  delete '/posts/:id/', to: 'posts#destroy', :as => :posts_destroy
  get '/search', to: 'searches#index', :as => :search_result
  get '/users/:id/restore_confirmation', to: 'users#restore_confirmation', :as => :users_restore_confirm
  patch '/users/:id/restore_confirmation', to: 'restore_confirmations#restore', :as => :users_restore
end


 root to: "tops#index"
 get 'tops/about', to: 'tops#about'
 post '/tops/guest_sign_in', to: 'tops#new_guest'

 resources :users
 resources :posts do
  resource :favorites, only: [:create, :destroy]
	resources :post_comments do
	get 'best_answer', to: 'posts#best_answer', :as => :post_best_answer
	patch 'best_answer', to: 'post_comments#authorize_best_answer'
    end
 end

get 'users/:id/destroy_confirmation', to: 'users#confirm', :as => :users_destroy_confirm

resources :relationships, only: [:create, :destroy]
get '/users/:id/follow/', to: 'users#follow', :as => :user_follow
get '/users/:id/follower/', to: 'users#follower', :as => :user_follower

get '/search', to: 'searches#index', :as => :search_result

resources :notifications, only: :index

end
