# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  resources :users, only: :show do
    resources :contacts, only: :show
    resources :user_files, only: %i[new create show]
  end

  root "pages#home"
end
