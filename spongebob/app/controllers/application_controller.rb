class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user_session, :current_user
  before_action :authorize, :login_required, :except => {:users=>:new,:users=>:create,:user_sessions=>:new,:user_sessions=>:create,:user_sessions=>:destroy}
  around_action :db_transaction, :pool

  rescue_from CanCan::AccessDenied do |exception|
    if @current_user
      redirect_to(request.referer || root_url , :notice => exception.message)
    else
      redirect_to(login_path, :notice => "You are not logged in.")
    end
  end

	def authorize
		unless self.class.can_access?(action_name, current_ability)
			logger.warn "ACL : ACCESS DENIED : You do not have permission on #{action_name}"
			raise CanCan::AccessDenied.new("You do not have permission.")
		end
	end

	def self.acl_check(*args)
		options= args.extract_options!
		acl_object = args.first || :all
		options.each do |actions,perms|
			[*actions].each{ |action|
				acl_checks[action.to_sym]||=[]
				acl_checks[action.to_sym] << [perms, acl_object]
			}
		end
	end

	class << self
		def acl_checks
			@acl_checks ||= {}
		end

		def can_access? action,ability
			checks= acl_checks[action.to_sym].to_a + acl_checks[:all_actions].to_a
			checks = [[:manage,:all]] if checks.blank?
			checks.each do |check|
				[*check.first].each do |perm|
					return false if ability.cannot? perm, check.second
				end
			end
			return true
		end
	end

	def login_required
		unless current_user
			session[:login_referer] = request.request_uri
			flash[:notice] = "Please Login to Proceed."
			redirect_to login_url
			return
		end
	end

	def redirect_url
		if session[:login_referer]
			retUrl = session[:login_referer]
			session[:login_referer] = nil
			return retUrl
		else
			return root_url
		end
	end

	def db_transaction
    include_in_txn = true
    excludes_actions = (Thread.current[:exclude_actions_from_txn]||[])

    include_in_txn = !excludes_actions.include?(action_name)

    if include_in_txn
      ActiveRecord::Base.transaction do
        yield
      end
    else
      logger.debug "NON-TRANSACTIONAL #{controller_name}##{action_name}"
      yield
    end
    #clean up the thread local as it may be pooled and reused
    Thread.current[:exclude_actions_from_txn] = nil
  end

  def pool
    ActiveRecord::Base.pooled do
      yield
    end
  end

  private
	def current_user_session
		return @current_user_session if defined?(@current_user_session)
		@current_user_session = UserSession.find
	end

	def current_user
		return @current_user if defined?(@current_user)
		@current_user = current_user_session && current_user_session.user
		ActiveRecord::Base.current_user= @current_user
		User.current_user = @current_user
		@current_user
	end
end
