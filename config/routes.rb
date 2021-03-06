Rails.application.routes.draw do

  get 'welcomes/index'

  get 'profiles/index'

  get 'profile/index'

 devise_for :user

 devise_for :restuarant



root to:"restuarants#show"

resources :restuarants do
  collection do
  end  
  member do 
      get 'staff'
      get 'add_drinking'
      get 'add_dessert'
      get 'add_dish'
      post 'add_staff'
      get 'show_staff'
      delete 'destroy_staff'
      get 'report'
    end
end

resources :billings   do
  member do
    get 'index_show'
    get 'report'
  end  
end

resources :registers

resources :waiters

resources :drinkings do
  member do
    patch 'update_drinking' 
  end
  collection do
    get  'drink_search'
  end
end

resources :desserts do
  member do
    patch 'update_dessert'
  end
  collection do
    get  'dessert_search'
  end
end

resources :dishs do
 member do
patch 'update_dish'
  end
  collection do
    get  'dish_search'
  end
end

resources :promotions do
  member do
  patch 'update_promotion'
  end
end

resources :bookings do
  member do
    patch 'update_booking'
  end
end

resource :users, only: [:edit, :update, :new]
  
 resources :tables
 resources :menu_lists do
  collection do
    get 'drinking'
    get 'dessert'
    get 'show'
   end
  member do
    patch 'create_menu'
    get 'payment'
    get 'service_bill'
    get "clear_table"
    get "cancle"
  end
end
  
 resources :showusers do 
 collection do
        get 'showusers'
    end
  end

  resources :profiles do 
 collection do
        get 'profiles'
    end
  end

   resources :orders do 
 collection do
        get 'orders'
    end
  end

  resources :kitchens do
    collection do
      get 'dish_kitchen'
      get 'drinking_kitchen'
      get 'dessert_kitchen'
    end
  end

  # collection do
  #       get 'tables'
  #   end
  # end
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
