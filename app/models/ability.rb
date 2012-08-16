class Ability
    include CanCan::Ability

    def initialize(user)
        user ||= User.new
                
        can [ :read, :feed ], [ Post, Tag ]
        can :search, Post     
        can [ :create, :read ], Comment
        
        if user.is_admin? then
            can [ :create, :manage ], [ Post, Tag ]
            can :manage, Comment
            can [ :read, :manage ], User
        end
  end
end
