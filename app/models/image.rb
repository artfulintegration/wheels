class Image < ActiveRecord::Base
  belongs_to :gallery
  acts_as_taggable
  has_attached_file :image,
      :storage => :s3,
      :s3_credentials => "#{Rails.root}/config/amazon_s3.yml",
      :path => "/images/:style/:filename",
      :styles => { :medium => "300x300>", :thumb => "100x100>" }
end

