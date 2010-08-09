class Blog < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user_id
  has_many :images
  cattr_reader :per_page
  @@per_page = 5
end

