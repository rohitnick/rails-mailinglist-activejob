Rails.application.routes.draw do
  resources :visitors, only: [:new, :create]
  get '/:referer_token' => 'visitors#new'
  root to: 'visitors#new'
end
