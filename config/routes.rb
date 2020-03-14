Rails.application.routes.draw do
  #rootでの参照先
  root to: 'messages#index'
  
  resources :messages
end
