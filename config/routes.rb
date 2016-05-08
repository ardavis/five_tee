Rails.application.routes.draw do

  devise_for :users
  root 'tasks#index'

  # Tasks
  patch 'tasks/filter' => 'tasks#filter'
  patch 'tasks/sort' => 'tasks#sort'


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




end
