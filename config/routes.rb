SampleApp::Application.routes.draw do

    resources :users do
        member do
            get :following, :followers
        end
    end

    post "users/1/edit"
    get "users/new"

    resources :users
    resources :microposts
    resources :sessions,      only: [:new, :create, :destroy]
    resources :microposts,    only: [:create, :destroy, :show]
    resources :relationships, only: [:create, :destroy]

    match '/signup', to: 'users#new'
    match '/signin', to: 'sessions#new'
    match '/signout', to: 'sessions#destroy', via: :delete

    root to: 'static_pages#home'

    match '/help',    to: 'static_pages#help'
    match '/about',   to: 'static_pages#about'
    match '/contact', to: 'static_pages#contact'

end

