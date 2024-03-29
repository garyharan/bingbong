Bingbong::Application.routes.draw do
  resources :potentials # until launch
  # root :to => "potentials#new"
  root :to => "searches#index"
  resources :searches
  resources :delivery_addresses, :except => :show

  resource :demo, :only => %w(show update)

  resources :shops do
    resources :time_blocks
    resources :orders, :controller => 'shops/orders', :as => 'shop_orders' do
      member do
        post :accept
        post :refuse
        post :tropo_answer
      end
    end
    resources :categories do
      resources :sizes
      resources :products
      resources :items
    end
  end

  # actual orders
  resources :lines
  resources :orders

  devise_for :users

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

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
end
