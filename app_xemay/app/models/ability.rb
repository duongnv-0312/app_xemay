class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    if user.is_admin?
      can :manage, :all
    elsif user.is_normal_user?
      can :manage, Comment, user_id: user.id
      can :read, Coordinate
      can :read, Image
      can [:create, :destroy], MarkedReview, user_id: user.id
      can :read, Product
      can :read, Review
      can [:create, :read], User
      can [:update, :destroy], User, id: user.id
      can :read, Region
    else
      can :read, :all
    end
  end
end
