module ActionDispatch::Routing
  class Mapper
    def wheels_resources
      resources :access_control_entries do
        collection do
          put :sort
        end
      end

      resources :app_configs do
        member do
          get :css
        end
      end

      resources :blogs, :path=>"blog"
      resources :external_links
      resources :feedbacks, :path=>"feedback", :only=>[:new, :index, :create]

      resources :forums do
        resources :discussions do
          resources :forum_messages
        end
      end

      resources :galleries do
        resources :images
      end

      resources :layouts
      resources :menus
      resources :pages do
        resources :attachments
        resources :children, :controller=>"pages", :as => "children"
      end

      resource  :profile
      resources :sitemaps

      devise_for :users
      resources :users do
        resources :blogs, :path=>"blog"
        resources :galleries
        resource  :profile
        member do
          get :verify
        end
      end

      match '/css' => 'app_configs#css'
      match '/admin' => "sitemaps#index"
      match "my_account" => "users#edit"
      match "change_password" => "users#change_password"
      match "verify_password" => "users#verify", :format=>:json
      match '/:level1(/:level2(/:level3(/:level4)))' =>'pages#show'

    end
  end
end

