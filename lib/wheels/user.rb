class User < ActiveRecord::Base
  before_create :create_profile
  belongs_to :role
  has_many :blogs, :dependent => :destroy
  has_one :profile, :dependent => :destroy
  has_many :galleries, :dependent => :destroy


  def create_profile
    self.profile ||= Profile.create(:user => self)
  end

  def role=(role)
    if role.kind_of? Role
      self.role_id = role.id
    else
      role = role.to_s.camelize
      if role.is_numeric?
        self.role_id= role
      else
        self.role_id= Role.find_by_name(role).id
      end
    end
  end

  def confirm!
    self.confirmed_at = DateTime::now
    save
  end

end

