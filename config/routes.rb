Rails.application.routes.draw do

  devise_for :users
  root 'tasks#index'

  resources :tasks

  resources :tags

  get '/tag_form' => 'tags#new_tag_form', as: 'tag_form'
  get '/tag/:id/destroy' => 'tags#destroy', as: 'destroy_tag'

  get '/tasks/:id/destroy' => 'tasks#destroy', as: 'destroy_task'
  get '/tasks/:id/complete' => 'tasks#complete', as: 'complete_task'
  get '/tasks/:id/start' => 'tasks#start', as: 'start_task'
  get '/tasks/:id/pause' => 'tasks#pause', as: 'pause_task'
  get '/tasks/:id/restart' => 'tasks#restart', as: 'restart_task'
  get '/select' => 'tasks#select', as: 'select'
  get '/edit' => 'tasks#edit', as: 'edit'
  post '/create' => 'tasks#create', as: 'create'

  #for downloading into xlsx file
  get '/download_all/' => 'tasks#download_all', as: 'download_all'
  get '/download_incompleted/' => 'tasks#download_incompleted', as: 'download_incompleted'
  get '/download_completed/' => 'tasks#download_completed', as: 'download_completed'



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
