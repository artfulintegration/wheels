class User < ActiveRecord::Base
  before_create :create_profile
  belongs_to :role

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable, :confirmable, :token_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.super_user
    @@super_user ||= User.where(:role_id=>Role::SUPER).first
  end

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

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation,
                  :blogs, :profile, :role, :galleries
end

