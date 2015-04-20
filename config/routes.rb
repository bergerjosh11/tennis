Tenisowo::Application.routes.draw do |map|
  devise_for :users
    
  root :to => "home#index"
    
  resource :profile
    
  map.connect "match_requests/:id/deny", {:controller => "match_requests", :action => "deny", :id => /[1-9]+[0-9]*/}
  map.connect "match_requests/:id/cancel", {:controller => "match_requests", :action => "cancel", :id => /[1-9]+[0-9]*/}
    
  map.connect "match_requests/:id/edit_deny", {:controller => "match_requests", :action => "edit_deny", :id => /[1-9]+[0-9]*/}
    
  map.connect "matches/:id/accept", {:controller => "matches", :action => "accept", :id => /[1-9]+[0-9]*/}
  map.connect "matches/:id/edit_accept", {:controller => "matches", :action => "edit_accept", :id => /[1-9]+[0-9]*/}  
  
  map.connect "matches/:id/deny", {:controller => "matches", :action => "deny", :id => /[1-9]+[0-9]*/}
  map.connect "matches/:id/edit_deny", {:controller => "matches", :action => "edit_deny", :id => /[1-9]+[0-9]*/}
    
  map.connect "matches/:id/ignore", {:controller => "matches", :action => "ignore", :id => /[1-9]+[0-9]*/}
  map.connect "matches/:id/stop_ignoring", {:controller => "matches", :action => "stop_ignoring", :id => /[1-9]+[0-9]*/}  
  
  resources :match_requests do
    resources :messages
  end
    
  resources :matches do
    resources :messages
    resources :rates
  end
  
  resources :messages
  
  resources :players do
    resources :match_requests
    resources :matches
  end
    
  namespace :user do
    root :to => "home#index"
  end

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

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
