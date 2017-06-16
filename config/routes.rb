Rails.application.routes.draw do

  root 'users#index'

  # ресурс пользователей
  resources :users

  # ресурс сессий (только три экшена :new, :create, :destroy)
  resources :sessions, only: [:new, :create, :destroy]

  # ресурс вопросов (кроме экшенов :show, :new, :index)
  resources :questions, except: [:show, :new, :index]
  
end
