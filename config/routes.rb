# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  resources :users, only: :show

  root "pages#home"
end
