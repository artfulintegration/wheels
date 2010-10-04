module PasswordValidators
  def self.included(base)
    attr_accessor :old_password
    validates :old_password, :presence=>true  , :password=>true
    validates :password, :presence=>true      , :length=>{:minimum=>6}
    validates :password_confirmation, :equal_to=>{:other=>:password}
  end
end

