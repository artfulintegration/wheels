class Ability
  include CanCan::Ability
  initializer :init_wheels

  def initialize(user)
    initializers.each{|t| self.send(t, user)}
  end

  def init_wheels(user)
    can :read, :all
    return cannot :read, User unless user
    roles = Role.all
    user ||= User.new
    def roles.find_by_name(name); self.select{|t| t.name==name}[0]; end;
    case user.role_id
      when roles.find_by_name("Super")
        can :manage, :all
      when roles.find_by_name("Admin")
        can :manage, :all
      when roles.find_by_name("User")
        can :manage, Gallery, :user_id => user.id
        can :manage, Blog, :user_id => user.id
        can :edit, Profile, :user_id => user.id
        cannot :read, User
    end
    can :read, :all
  end


  def self.initializer(*method_names)
    method_names.each{|t| initializers << t}
  end

  def initializers
    @initializers ||= []
  end


end

