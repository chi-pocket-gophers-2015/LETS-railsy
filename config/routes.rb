Rails.application.routes.draw do

    root to: 'decisions#index'

    get "login" => "sessions#new", :as => "login"
    get "logout" => "sessions#destroy", :as => "logout"

    get "profile" => "decisions#index", :as => "profile"

    resources :sessions, only: [:new, :create, :destroy]
    resources :users, only: [:new, :create] do #, :show
      resources :decisions, only: [:index]
    end

    resources :decisions, only: [:new, :create, :show, :destroy]  do
      member do
        get 'something_changed'
      end
      resources :participations, only: [:new, :create]
      resources :proposals, only: [:new, :create] do
        resources :queries, only: [:update]
      end
    end

    # resources :users, only: [:create] do
    #   resources :decisions, only: [:create, :update, :index, :show]# do
    #     # resources :participations, only: [:index]
    #   # end
    # end

    # resources :decisions, only: [:create, :update, :show] do
    #   resources :proposals, only: [:create, :update, :show] do
    #     resources :queries, only: [:create, :update]
    #   end
    # end

    # resources :decisions, only: [:index, :show, :create, :update] do
    #   resources :participations, only: [:index,:create, :destroy]
    # end

    # match '/decisions/:id/activeproposal' => 'decisions#activeproposal', :via => :get, as: "decision_active_proposal"
    # get '/decisions/:id/activeproposal' => 'decisions#activeproposal', as: "decision_active_proposal"
end
