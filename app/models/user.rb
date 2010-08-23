class User < ActiveRecord::Base
  after_create :create_profile
  belongs_to :role
  has_many :blogs, :dependent => :destroy
  has_one :profile, :dependent => :destroy
  has_many :galleries, :dependent => :destroy
  has_many :access_control_entries, :dependent=>:destroy

  def self.nobody
    User.new(:role=>Role.nobody)
  end

  def self.root
    User.where(:role_id=>Role.root.id)[0]
  end

  def create_profile
    Profile.create(:user=>self) unless self.profile
  end

  def role?(role)
    if role.kind_of?(Role)
      return role==self.role
    elsif role.is_numeric?
      return self.role_id==role
    else
      return self.role.name.underscore==role.underscore
    end
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
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable, :lockable, :timeoutable

end

