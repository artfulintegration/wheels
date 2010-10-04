class Menu < ActiveRecord::Base
  has_many :sitemaps, :as=>:resource
  alias_attribute :name, :title
end

