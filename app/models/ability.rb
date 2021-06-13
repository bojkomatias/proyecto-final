# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    if user.id == 1
      can :manage, :all
    end
    if user.admin?
      can :manage, :all
    else
      can [:index, :create, :update, :destroy], Account
      can [:index, :create, :show] ,Transfer
      can [:index, :create, :update, :show, :destroy], Budget
      can [:create], Item
      can [:index, :show], Category
      can :read, User, :id => user.id
      can :update, User, :id => user.id
    end
  end
end
