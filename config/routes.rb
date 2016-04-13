Rails.application.routes.draw do

  devise_for :users, :controllers => {:sessions => 'sessions'}
  root 'tasks#index'

  resources :tasks

  resources :tags


  get '/archive/create' => 'archives#create', as: 'new_archive'
  get '/archives/show' => 'archives#show', as: 'show_archives'
  get '/archives/:id/destroy' => 'archives#destroy', as: 'destroy_archive'

  get '/new_tag_modal' => 'modals#new_tag_modal', as: 'new_tag_modal'

  get '/tag/:id/destroy' => 'tags#destroy', as: 'destroy_tag'
  get '/tags/:name/create' => 'tags#create'
  get '/tags/:id/select' => 'tags#select'
  get '/manage_tag_modal' => 'modals#manage_tag_modal', as: 'manage_tag_modal'

  devise_scope :user do
    get '/session/:filter_tag_id/update_filter' => 'sessions#update_filter_sort'
    get '/session/:sort_sql/update_sort' => 'sessions#update_filter_sort'
  end

  get '/tasks/:id/show' => 'tasks#show_task', as: 'show_task'
  get '/tasks/:id/destroy' => 'tasks#destroy', as: 'destroy_task'
  get '/tasks/:id/complete' => 'tasks#complete', as: 'complete_task'
  get '/tasks/:id/start' => 'tasks#start', as: 'start_task'
  get '/tasks/:id/pause' => 'tasks#pause', as: 'pause_task'
  get '/tasks/:id/restart' => 'tasks#restart', as: 'restart_task'
  post '/tasks/create' => 'tasks#create'
  get '/reset_all_tasks' => 'tasks#reset_all', as: 'reset_all_tasks'

  get '/show_task_modal' => 'modals#show_task_modal', as: 'show_task_modal'
  get '/edit_task_modal' => 'modals#edit_task_modal', as: 'edit_task_modal'
  get '/new_task_modal' => 'modals#new_task_modal', as: 'new_task_modal'
  get '/update_duration_modal' => 'modals#update_duration_modal', as: 'update_duration_modal'
  get '/reset_tasks_modal' => 'modals#reset_tasks_modal', as: 'reset_tasks_modal'

  patch '/update_duration' => 'tasks#update_duration', as: 'update_duration'
  # post '/create' => 'tasks#create', as: 'create'
  post '/tasks/test' => 'tasks#test', as: 'test'


  #for downloading into xlsx file
  get '/download_all/' => 'tasks#download_all', as: 'download_all'
  get '/download_incompleted/' => 'tasks#download_incompleted', as: 'download_incompleted'
  get '/download_completed/' => 'tasks#download_completed', as: 'download_completed'

end
