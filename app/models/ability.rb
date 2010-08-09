class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all
    return cannot :read, User unless user
    user ||= User.new
    case user.role_id
      when Role::SUPER
        can :manage, :all
      when Role::ADMIN
        can :manage, :all
      when Role::USER
        can :manage, Gallery, :user_id => user.id
        can :manage, Blog, :user_id => user.id
        can :edit, Profile, :user_id => user.id
        cannot :read, User
    end
    can :read, :all

  end
end

