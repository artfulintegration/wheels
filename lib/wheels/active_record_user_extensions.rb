module Wheels
  module ActiveRecordUserExtensions
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
end

User.send :include, Wheels::ActiveRecordExtensions

User.before_create :create_profile
User.belongs_to :role
User.has_many :blogs, :dependent => :destroy
User.has_one :profile, :dependent => :destroy
User.has_many :galleries, :dependent => :destroy

