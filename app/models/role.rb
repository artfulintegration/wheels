class Role < ActiveRecord::Base
  has_many :users

  SUPER = 1
  ADMIN = 2
  USER = 3
end

