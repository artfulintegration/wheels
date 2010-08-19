module ActionDispatch::Routing
  class Mapper
    def wheels_resources
      resources :galleries do
        resources :images
      end
      resource :profile
      resources :blogs, :path=>"blog"

      devise_for :users

      resources :users do
        resource :profile
        resources :galleries
        resources :blogs, :path=>"blog"
      end

      resources :layouts
      resources :forums do
        resources :discussions do
          resources :forum_messages
        end
      end

      resources :pages do
        resources :attachments
        resources :children, :controller=>"pages", :as => "children"
      end

      scope "/admin" do
        resources :access_control_entries
        resources :users
      end

    end
  end
end

