Rails.application.routes.draw do

  devise_for :users
  root 'tasks#index'

  # Tasks
  get 'tasks/fetch_all' => 'tasks#fetch_all'


  # Task Buttons

  patch 'tasks/start' => 'tasks#start'
  patch 'tasks/pause' => 'tasks#pause'
  patch 'tasks/complete' => 'tasks#complete'
  patch 'tasks/delete' => 'tasks#delete'
  patch 'tasks/restart' => 'tasks#restart'

  # Task Links

  patch 'tasks/select' => 'tasks#select'

end
