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
        resources :blogs, :path=>"blog" do
          resources :blog_images, :path=>"images"
        end
      end
      scope :module=>"admin" do
        resources :users
      end
    end
  end
end

