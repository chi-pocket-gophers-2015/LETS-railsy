Rails.application.routes.draw do

    get "login" => "sessions#create", :as => "login"
    get "logout" => "sessions#destroy", :as => "logout"

    resources :sessions, only: [:create, :destroy]
    resources :users, only: [:create, :show]

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
