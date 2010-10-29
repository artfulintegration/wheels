class User < ActiveRecord::Base
  belongs_to :role
  has_many :blogs, :dependent => :destroy
  has_one :profile, :dependent => :destroy
  has_many :galleries, :dependent => :destroy
  has_many :access_control_entries, :dependent=>:destroy
  before_create :create_profile

  validates :role, :presence => true

  accepts_nested_attributes_for :profile

  def initialize(*args)
    super(*args)
  end

  def self.nobody
    User.new(:role=>Role.nobody)
  end

  def self.root
    User.where(:role_id=>Role.root.id)[0]
  end

  def create_profile
    unless self.profile
      build_profile(:alias=>email)
      profile.save
    end
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

class FullyValidatedUser < User
  def class
    User
  end
  _validators[:password].delete_if{|t| t.is_a? ActiveModel::Validations::PresenceValidator}
  attr_accessor :old_password
  validates :email, :presence => true, :email => true
  validates :old_password, :presence=>true, :password=>true
  validates :password, :length=>{:minimum=>6}
  validates :password_confirmation, :equal_to=>{:other=>:password}
end

