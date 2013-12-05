Mailagent::Application.routes.draw do
  
  # session functionality
  get 'start' => 'session#new'
  post 'start' => 'session#create'
  delete 'logout' => 'session#destroy'
  
  # feedback
  get "feedback/new"
  post "feedback/new" => "feedback#create"
  
  #import
  get "import" => 'import#index'
  post "import/new_users" => 'import#new_users'
  post "import/assign_lists" => 'import#assign_lists'
  post "import/generic_import" => 'import#generic_import'
  
  # dashboard
  get "dashboard" => 'dashboard#index'
  
  # limit incoming mails to mailserver ip
  if Rails.env.production?
    post "incoming_messages" => 'incoming_message#create', :constraints => {:ip => /127.0.0.1/}
    else
    post "incoming_messages" => 'incoming_message#create'
  end 
    
  #resources :emails
  get 'emails' => 'emails#index'
  delete "emails/:id" => 'emails#destroy', as: 'email'
  
  #resources :subscriptions
  delete "subscriptions/:id" => 'subscriptions#destroy', as: 'subscription'

  resources :lists

  resources :users
  get 'profile' => 'users#profile'
  get 'edit_profile' => 'users#edit_profile'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'session#new'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
