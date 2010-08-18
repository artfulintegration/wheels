class Attachment < ActiveRecord::Base
  validates_presence_of :resource_id, :resource_class_name, :file

  has_attached_file :file,
      :storage => :s3,
      :s3_credentials => "#{Rails.root}/config/amazon_s3.yml",
      :path => "/product_revision/:filename"

end

