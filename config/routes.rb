Rails.application.routes.draw do

  get 'daily_clears/show'
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
    end
    member do
      get :complete
    end
  end

  resources :daily_clears, only:[:show, :create, :update]
  resources :time_attacks, only:[:create, :update, :index]
  resources :records, only:[:new, :create, :index, :destroy]
  resources :small_goals, only:[:create, :update, :destroy]
  resources :calendars, only:[:index, :create, :update]
  resources :gantts, only:[:index, :create, :edit, :update]
end
