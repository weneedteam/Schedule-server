Rails.application.routes.draw do
  root to: "home#index"
  
  namespace :v1 do
    get   'holidays'          => 'holiday#index'

    post  'user'              => 'user#index'
    post  'user/email'        => 'user#email'
    post  'user/password'     => 'user#password'
    post  'user/password/new' => 'user#new_password'
    post  'fcm_token'         => 'user#fcm_token'

    get   'friends'             => 'friend#index'
    post  'friends/new'         => 'friend#new'
    post  'friends/:id/consent' => 'friend#consent'

    get    'schedule'            => 'schedule#index'
    post   'schedule/new'        => 'schedule#new'
    get    'schedule/:id'        => 'schedule#show'
    post   'schedule/edit/:id'   => 'schedule#update'
    delete 'schedule/:id'        => 'schedule#delete'
    post   'schedule/:id/arrive' => 'schedule#arrive'
  end

  devise_for :users, :controllers => { 
    sessions:      'v1/sessions', 
    registrations: 'v1/registrations',
    passwords:     'v1/passwords'
  }

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
