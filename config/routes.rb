Rails.application.routes.draw do
 
  get 'customers/index'

  get 'drivers/index'

 devise_for :drivers, controllers: { registrations: "drivers/registrations" }
  devise_for :users, controllers: { sessions: "customers/sessions", registrations: "customers/registrations", passwords: "customers/passwords", confirmations: "customers/confirmations" }
get 'customers/allocate'
 
  

devise_scope :user do

  authenticated :user, lambda { |u| u.has_attribute? :admin } do
     resources :drivers
     resources :appointments
     get 'drivers/index'
     get '/drivers/sign_up'
     get 'customers/allocate'
      
    end
  
  authenticated :user do
    root 'appointments#index'
    resources :appointments

  end

  unauthenticated  do
    root 'customers/sessions#new', as: :unauthenticated_root
    end
  end
end
