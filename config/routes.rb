Rails.application.routes.draw do
  resources :faces
  root 'application#home'

  resources :faces do
    post :verify, on: :collection
  end
end
