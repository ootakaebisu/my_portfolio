Rails.application.routes.draw do

  root 'homes#top'
  devise_for :users
  resources :users, only:[:show, :index, :edit, :update] do
    collection do
      get :result
      get :unsubscribe
      patch :withdraw
      get :follow_users
    end
    member do
      get :public
    end
  end

  resources :missions, only:[:new, :create, :show, :edit, :update] do
    collection do
      get :result
      get :daily_clear
    end
    member do
      get :complete
    end
  end

  resources :time_attacks, only:[:new, :create, :index]
  resources :records, only:[:index]
  resources :calendars, only:[:show, :create, :update]
  resources :gantts, only:[:show, :create, :edit, :update]
end
