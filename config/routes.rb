Rails.application.routes.draw do
  devise_for :users, controllers: {
    confirmations: 'confirmations'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_scope :user do
    post "sign_up", to: "registrations#create"
    post "sign_in", to: "sessions#create"
    delete "log_out", to: "sessions#destory"
  end
  resource :activities, only: [ :show, :create, :update, :destory ]
  resource :user_profiles, only: [ :show, :create, :update, :destory ]
end
