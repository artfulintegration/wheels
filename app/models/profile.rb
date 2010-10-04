class Profile < ActiveRecord::Base
  acts_as_tagger
  belongs_to :user
  # validates_uniqueness_of :alias
  # validates :phone, :phone=>true
  has_attached_file :image,
      :storage => :s3,
      :s3_credentials => "#{Rails.root}/config/amazon_s3.yml",
      :path => "/:style/:filename",
      :styles => { :medium => "300x300>", :thumb => "100x100>" }
end

