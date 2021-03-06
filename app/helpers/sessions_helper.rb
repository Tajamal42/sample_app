module SessionsHelper

	def sign_in(user)
        session[:user_id] = user.id
        self.current_user = user
    end

    def current_user=(user) 
        @current_user= user
    end

    def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

	def signed_in?
		!current_user.nil?
	end

	def sign_out
		session[:user_id] = nil
		self.current_user = nil
	end

	def current_user?(user) 
       user == current_user 
    end

    def deny_access
    	redirect_to signin_path, :notice => "Please sign in to access this page"
    end

    def redirect_back_or(default)
        redirect_to(session[:return_to] || default)
        session.delete(:return_to)
    end
    
    def store_location
        session[:return_to] = request.fullpath
    end

    def signed_in_user
      unless signed_in?
      store_location
      redirect_to new_session_path, notice: "Please Sign In."
      end
    end
end
