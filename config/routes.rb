Rails.application.routes.draw do

    root to: 'sessions#new'

    get "login" => "sessions#new", :as => "login"
    get "logout" => "sessions#destroy", :as => "logout"

    resources :sessions, only: [:new, :create, :destroy]
    resources :users, only: [:new, :create, :show] do
      resources :decisions, only: [:index]
    end

    resources :decisions, only: [:new, :create, :show]  do
      resources :participations, only: [:new, :create]
      resources :proposals, only: [:new, :create] do
        resources :queries, only: [:create]
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
