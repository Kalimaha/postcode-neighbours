Rails.application.routes.draw do
  get 'welcome/index'
  post '/search' => 'welcome#search'

  root 'welcome#index'
end
