Rails.application.routes.draw do

  get 'daily_clears/show'
  root 'homes#top'
  devise_for :users,
  controllers: {
    omniauth_callbacks: 'omniauth_callbacks'
  }

  resources :users, only:[:show, :index, :edit, :update] do
    collection do
      get :result
      get :unsubscribe
      patch :withdraw
    end
    member do
      get :public_page
      get :follow_users
    end
  end

  resources :missions, only:[:new, :create, :show, :edit, :update, :destroy] do
    collection do
      get :result
    end
    member do
      get :complete
    end
  end

  post 'create/:id' => 'relationships#create', as: 'follow' # フォローする
  post 'destroy/:id' => 'relationships#destroy', as: 'unfollow' # フォロー外す

  resources :daily_clears, only:[:show, :create, :update]
  resources :time_attacks, only:[:create, :update, :index]
  resources :records, only:[:new, :create, :index, :destroy]
  resources :small_goals, only:[:create, :update, :destroy] do
    # put :sort
    collection do
      put 'sort/:small_goal_id', action: 'sort', as: 'sort'
    end
  end
  resources :calendars, only:[:index, :show, :create, :update]
  resources :gantts, only:[:index, :create, :edit, :update]
end
