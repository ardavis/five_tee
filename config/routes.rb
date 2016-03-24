Rails.application.routes.draw do

  devise_for :users, :controllers => {:sessions => 'sessions'}
  root 'tasks#index'

  resources :tasks

  resources :tags

  get '/new_tag_modal' => 'modals#new_tag_modal', as: 'new_tag_modal'
  get '/tag/:id/destroy' => 'tags#destroy', as: 'destroy_tag'
  get '/manage_tag_modal' => 'modals#manage_tag_modal', as: 'manage_tag_modal'

  devise_scope :user do
    get '/session/update_filter_sort' => 'sessions#update_filter_sort', as: 'update_filter_sort'
  end

  get '/tasks/:id/destroy' => 'tasks#destroy', as: 'destroy_task'
  get '/tasks/:id/complete' => 'tasks#complete', as: 'complete_task'
  get '/tasks/:id/start' => 'tasks#start', as: 'start_task'
  get '/tasks/:id/pause' => 'tasks#pause', as: 'pause_task'
  get '/tasks/:id/restart' => 'tasks#restart', as: 'restart_task'
  get '/show_task_modal' => 'modals#show_task_modal', as: 'show_task_modal'
  get '/edit_task_modal' => 'modals#edit_task_modal', as: 'edit_task_modal'
  get '/new_task_modal' => 'modals#new_task_modal', as: 'new_task_modal'
  get '/update_duration_modal' => 'modals#update_duration_modal', as: 'update_duration_modal'
  patch '/update_duration' => 'tasks#update_duration', as: 'update_duration'
  post '/create' => 'tasks#create', as: 'create'
  post '/tasks/test' => 'tasks#test', as: 'test'


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
