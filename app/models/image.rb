class Image < ActiveRecord::Base
  belongs_to :gallery
  has_attached_file :image,
      :storage => :s3,
      :s3_credentials => "#{Rails.root}/config/amazon_s3.yml",
      :path => "/:style/:filename"
end

