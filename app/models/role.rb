class Role < ActiveRecord::Base
  has_many :users
  has_many :access_control_entries

  def self.collection_entries
    roles = [["Not Set", nil]]
    Role.all.map{|t| [t.name, t.id]}.each do |t|
      roles << t
    end
    roles
  end

  SUPER = 1
  ADMIN = 2
  USER = 3
end

