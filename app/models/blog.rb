class Blog < ActiveRecord::Base
  acts_as_taggable
  belongs_to :user
  validates_presence_of :user_id, :title
  acts_as_linkable :parent=>:user, :name=>:title
  has_many :images
  cattr_reader :per_page
  @@per_page = 5
end

