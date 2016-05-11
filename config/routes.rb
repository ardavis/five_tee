Rails.application.routes.draw do

  devise_for :users
  root 'tasks#index'

  # Tasks
  get 'tasks/index' => 'tasks#index'
  patch 'tasks/filter' => 'tasks#filter'
  patch 'tasks/sort' => 'tasks#sort'
  patch 'tasks/reset' => 'tasks#reset'
  get 'tasks/download' => 'tasks#download'


  # Task Buttons

  patch 'tasks/new' => 'tasks#new'
  patch 'tasks/start' => 'tasks#start'
  patch 'tasks/pause' => 'tasks#pause'
  patch 'tasks/complete' => 'tasks#complete'
  patch 'tasks/delete' => 'tasks#delete'
  patch 'tasks/restart' => 'tasks#restart'

  # Task Forms

  patch 'tasks/update' => 'tasks#update'

  # Task Links

  patch 'tasks/select' => 'tasks#select'

  # Tags

  patch 'tags/new' => 'tags#new'
  patch 'tags/update' => 'tags#update'
  patch 'tags/delete' => 'tags#delete'

  # Archives
  get 'archives/index' => 'archives#index'
  patch 'archives/new' => 'archives#new'
  patch 'archives/delete' => 'archives#delete'
  patch 'archives/reset' => 'archives#reset'




end
