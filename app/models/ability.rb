class Ability
  include CanCan::Ability

  def initialize(admin)
    admin = admin or Admin.new

    if admin.superadmin?
        can :manage, Event
    else
        can :manage, Event, admin_id: admin.id
    end
  end
end
