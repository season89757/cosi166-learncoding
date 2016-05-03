Rails.application.routes.draw do

  get 'userphotos/index'

  get 'userphotos/new'

  get 'userphotos/create'

  get 'userphotos/destroy'

  post 'comment/create'

  get 'search_box/search_results'

  get 'search_box/book_detail'

  post "search_box/comment"

  get "search_box/sectioncomment"

  get "search_box/sectiondetail"

  get "search_box/sectionpreview"

  resources :userphotos, only: [:index, :new, :create, :destroy]

  get "imdb/new_release" => 'imdb#new_release', :as => :new_release

  resources :books
  resources :forums do
    resources :posts do
      resources :postreplies
    end
  end
  resources :posts
  resources :postreplies


  post 'imdb/register'

  root 'imdb#index'

  get 'imdb/login'

  get 'users/new'

  get 'imdb/index'

  get 'imdb/register'

  get 'imdb/detail'

  get 'imdb/logout'

  get 'imdb/searchresult'

  get 'users/profile'


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
