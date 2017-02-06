Rails.application.routes.draw do
  # Root route
  root 'static#index'

  # Static pages Basic Routes
  get 'static/index'
  get 'static/about'
  get 'static/contact'

  # Static Page Sign Up/Sign in User
  get 'sign_up' => 'static#sign_up'
  get 'sign_in' => 'static#sign_in'
  post 'user_signup' => 'static#sign_up'
  post 'user_signin' => 'static#sign_in'

  # User Specific Routes
  get 'user_index' => 'users#index'
  get 'user_logout' => 'users#logout'

  get 'activate_user' => 'users#activate'

  # Server errors
  get 'server_error' => 'static#server_path'

  namespace :api do
    namespace :v1 do
      # Any API routes would go here

      #Good Crud stuff
      get 'users/index'
    end
  end

  # Match any path that doesn't exist to page not found.
   match "*path", to: "application#page_not_found", via: :all


   # Examples

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

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
