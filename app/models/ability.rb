class Ability
  include CanCan::Ability

  def initialize(user)

     if user.chef?
        can :manage, Recipe, user_id: user.id
        can :manage, Ingredient
        else
            can :read, Recipe
            can :read, Ingredient
        end
  end
end
