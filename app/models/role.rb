class Role < ActiveRecord::Base
  has_many :users
  has_many :access_control_entries

  def self.root
    @root ||= find_by_name("Super")
  end

  def self.nobody
    @nobody ||= find_by_name("Nobody")
  end

  def self.user
    @user ||= find_by_name("User")
  end

  def self.admin
    @admin ||= find_by_name("Admin")
  end

  def self.collection_entries
    roles = [["Not Set", nil]]
    Role.all.map{|t| [t.name, t.id]}.each do |t|
      roles << t
    end
    roles
  end
end

