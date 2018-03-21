class SessionsController < ApplicationController

	def new
		#Login Form
	end

	def create
		if user = User.authenticate(params[:session][:email], params[:session][:password])
        sign_in user
        session[:user_id] = user.id
        redirect_to user
        else
        	# If user's login doesn't work, send them back to the login form.
        	flash[:notice] = "Invalid Username or Password"
      		render "new"
        end
	end

	def destroy
		sign_out
		session[:user_id] = nil
		redirect_to :action => 'new', notice: 'Logged out!'
	end

end
