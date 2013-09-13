PetSquare::Application.routes.draw do

  # The priority is based upon order of creation:
  # first created -> highest priority.
  root :to => 'pages#home'
  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action
  match '/about', to: 'pages#about'
  match '/contact', to: 'pages#contact'
  match '/faq', to: 'pages#faq'
  match '/signup', to: 'users#new'
  match '/signin', to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete
  match '/searchPlace', to: 'places#search_form'
  match '/searchPet', to: 'pets#search_form'
  match '/addPet', to: 'pets#new'
  match '/addPlace', to: 'places#new'

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  resources :users do
      member do
        get :pets
        get :following
      end
  end

  resources :pets do
    member do
      get :followers
    end

    collection do
      get :search
    end
  end

  resources :sessions, only: [:new, :create, :destroy]

  resources :places do
    resources :checkins
    resources :reviews
    resources :pets

    collection do
      get :search
    end
  end

  resources :relationships, only: [:create, :destroy]

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.


  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
