class Page < ActiveRecord::Base
  has_many :attachments
  has_many :sitemaps, :as=>:resource
  has_many :access_control_entries, :as=>:resource
  alias_attribute :name, :title
  acts_as_taggable
end

