Rails.application.routes.draw do
  root 'pages#front'
  mount Ckeditor::Engine => '/ckeditor'

  # Assistant session
  get "/signin", to: "sessions#new"
  post "/signin", to: "sessions#create"
  delete "/signout", to: "sessions#destroy"

  # Manager session
  get "/mmw_signin", to: "sessions#manager_new"
  post "/mmw_signin", to: "sessions#manager_create"
  delete "/mmw_signout", to: "sessions#manager_destroy"

  # 助理後台
  namespace :staff do
    root "categories#index"

    resources :categories, only: [:show, :index]

    resources :items do
      resources :photos, except: [:show]

      resources :item_specs, except: [:show]
    end
  end

  # 管理員後台
  namespace :admin do
    root "categories#index"

    resources :items do
      collection do
        get "search"
      end

      member do
        patch "on_shelf"
        patch "off_shelf"
      end

      resources :photos, except: [:show]

      resources :item_specs, except: [:show] do
        member do
          patch "on_shelf"
          patch "off_shelf"
        end        
      end         
    end
    
    resources :categories, only: [:new, :create, :show, :index] do
      # 商品重新排序
      collection do
        post "sort_items_priority"
      end
    end
    
    resources :users, only: [:index, :show, :create, :update] do
      collection do
        # 外界POST request
        post "import_user", to: "users#import_user"
      end
    end

    get "users/show_uid/:uid", to: "users#show_uid", as: "uid_user"

    resources :counties, only: [:index, :show] do
      resources :towns, only: [:index, :show] do
        resources :roads, only: [:index, :show] do
          resources :stores, only: [:index, :show]
        end
      end
    end

    resources :orders, only: [:index, :show] do
      collection do
        get "exporting_files"
      end

      member do
        patch "order_processing"
        patch "item_shipping"
        patch "item_shipped"
        patch "order_cancelled"
      end
    end

    # 註冊裝置
    resources :device_registrations, only: [:index, :show]

    # 推播訊息
    resources :notifications, only: [:index, :show, :new, :create]
  end

  # API for App
  namespace :api do
    namespace :v1 do
      # 分類API
      resources :categories, only: [:index, :show]

      # 商品API
      resources :items, only: [:index, :show] do
        member do
          # 商品樣式資料
          get "spec_info"
        end
      end

      # 用戶API
      resources :users, only: [:create, :show, :update]

      # 訂單API
      resources :orders, only: [:create, :show, :index] do
        collection do
          get "/user_owned_orders/:uid" => "orders#user_owned_orders"
        end
      end

      # 超商API
      resources :counties, only: [:index, :show] do
        resources :towns, only: [:index, :show] do
          resources :roads, only: [:index, :show] do
            resources :stores, only: [:index, :show]
          end
        end
      end

      # 註冊裝置
      resources :device_registrations, only: [:create]
    end

    namespace :v2 do
      # 訂單API
      resources :orders, only: [:show, :index] do
        collection do
          get "/user_owned_orders/:uid" => "orders#user_owned_orders"
        end
      end
    end
  end
end