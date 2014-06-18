Rails.application.routes.draw do

  devise_for :admins
  devise_for :users
  get 'users/:id' => 'users#show', as: 'users'
  get 'users/:id' => 'users#show', as: 'user'

  resources :tutorials do
    resources :tutorial_grades, only: [:create]
    resources :tutorial_comments, path: 'comments', only: [:create,:update,:destroy] do
      resources :tutorial_comment_votes, only: [:create,:update,:destroy]
    end
    resources :parts do
      get 'up_position', on: :member
      get 'down_position', on: :member
      resources :part_votes,only: [:create,:update,:destroy]
      resources :done_parts,only: [:create,:destroy]
      resources :part_comments, path: 'comments', only: [:index,:create,:update,:destroy] do
        resources :part_comment_votes, only: [:create,:update,:destroy]
      end
    end
  end

  resources :interpreters do
    resources :interpreter_grades, only: [:create]
    resources :interpreter_comments, path: 'comments', only: [:create,:update,:destroy] do
      resources :interpreter_comment_votes, only: [:create,:update,:destroy]
    end
    resources :functions do
      resources :function_votes,only: [:create,:update,:destroy]
      resources :function_comments, path: 'comments', only: [:index,:create,:update,:destroy] do
        resources :function_comment_votes, only: [:create,:update,:destroy]
      end
    end
  end

  get '/home' => 'page#home'
  get '/creator' => 'page#creator'
  get '/about' => 'page#about'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'page#home'

  # devise_for :users, path: "auth", path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in' }

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
