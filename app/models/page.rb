class Page < ActiveRecord::Base
  has_many :images
  acts_as_taggable
end

