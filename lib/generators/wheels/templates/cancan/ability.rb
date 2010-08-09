class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, :all
#    if user.admin?
#      can :manage, :all
#    else
#      can :read, :all
#    end
  end
end

