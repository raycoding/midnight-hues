class Ability
  include CanCan::Ability

  def can_access?(link)
    return true if link.blank?
    act = ActionController::Routing::Routes.recognize_path(link, {:method => :get})
    cont_name = act[:controller]
    if !cont_name
      return can? :manage, :all
    end
    act_name = act[:action]
    if !act_name
      return true
    end
    klass_name = cont_name.camelize+"Controller"
    klass=klass_name.split("::").inject(Kernel) {|p,n| p.const_get(n) }
    klass.can_access?(act_name,self)
  end

  def initialize(user)
    if user
      can :manage, :cal_login
      user.permissions.each do |p|
        if p[0].starts_with?(':')
          first = p[0].gsub(':','').to_sym
        else
          first = p[0].constantize
        end
        if p[1].starts_with?(':')
          last = p[1].gsub(':','').to_sym
        else
          last=p[1].constantize
        end
          can first,last
      end
    end
  end
end