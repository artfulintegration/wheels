class Attachment < ActiveRecord::Base
  validates_presence_of :file, :page_id
  belongs_to :page

  has_attached_file :file,
      :storage => :s3,
      :s3_credentials => "#{Rails.root}/config/amazon_s3.yml",
      :path => "/attachments/:filename"
end

