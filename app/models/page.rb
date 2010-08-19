class Page < ActiveRecord::Base
  has_many :attachments
  validates_presence_of :title
  belongs_to :parent, :class_name=>'Page', :foreign_key=>'parent_id'
  has_many :children, :class_name=>'Page', :foreign_key=>'parent_id'
  acts_as_taggable

  scope :orphans, where(:parent_id=>nil)
end

