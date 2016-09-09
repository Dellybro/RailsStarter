module UsersHelper

	#Delets the cookies and the remember_token for the user
	def forget_user(user)
		user.forget
		cookies.delete(:user_id)
		cookies.delete(:remember_token)
	end

	#This method will remember you by using a cookie. Permanent
	def remember_user(user)
		user.remember
		cookies.permanent.signed[:user_id] = user.id
		cookies.permanent[:remember_token] = user.remember_token
	end

	#login in the user.
	def log_in_user(user)
		session[:user_id] = user.id
	end

	#gets the current user
	def current_user(id=nil)
		if user_id = session[:user_id]
			@current_user ||= User.find_by(id: session[:user_id])
		end 
	end
	#check if user is the current user
	def current_user?(user)
		user == current_user
	end

	#Checks to see if their is a current user logged_in
	#This method calls the current_user method
	def logged_in_user?
		!current_user.nil?
	end
	#logs out the current user
	def log_out_user
		forget_user(current_user)
		session.delete(:user_id)
		@current_user = nil
	end

	#Redirects to the session fowardurl which created when we store_location if the user comes back
	def redirect_back_or(default)
		redirect_to(session[:forwarding_url] || default)
		session.delete(:forwarding_url)
	end

	#Store url trying to be accessed
	def store_location
		session[:forwarding_url] = request.url if request.get?
	end
end

