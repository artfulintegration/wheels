class Ability
  include CanCan::Ability
  def self.initializers
    @initializers ||= []
  end

  def self.initializer(*method_names)
    method_names.each{|t| initializers << t}
  end
  initializer :init_wheels

  def initialize(user)
    user ||= User.nobody
    puts all_aces_for(user).map{|t| "#{t.resource_class_name} #{t.options.inspect}"}.join("\n")
    self.class.initializers.each{|t| self.send(t, user)}
    all_aces_for(user).each do |ace|
      ace.configure(self)
    end
  end

  def all_aces_for(user)
    (user.access_control_entries + user.role.access_control_entries)
  end

  def init_wheels(user)
    can :read, :all
    roles = Role.all
    def roles.find_by_name(name); self.select{|t| t.name==name}[0]; end;
    case user.role.id
      when roles.find_by_name("Super").id
        can :manage, :all
      when roles.find_by_name("Admin").id
        can :manage, :all
      when roles.find_by_name("User").id
        can :manage, Gallery, :user_id => user.id
        can :manage, Blog, :user_id => user.id
        can :edit, Profile, :user_id => user.id
        cannot :read, User
    end
  end
end

