class UsersController < ApplicationController
	before_action :logged_in_user, except: [:activate]
	layout :get_layout

	def get_layout
		"user_application"
	end

	def index
	end

	# Route is accessible via GET
	# Logs out the user IF the user is logged in. (Done in Users Helper)
	# Create Flash warning -- Redirect to Root
    def logout
        log_out_user if logged_in_user?
        flash[:success] = [AlertMessage.new(message: "Thanks for visiting us!")]
        redirect_to root_path
    end

    # Activate the User
    # User find by email, than using the "authenticated?" method on the user, uncrypt the token, and check to see if it's the correct token
    # If true we use the "activate" method to activate the user (Methods can be found in the User Model, /app/models/user)
    def activate
    	@user = User.find_by(:email => params[:email])
    	if @user
    		if @user.authenticated?(:activation, params[:token])
    			@user.activate
		        flash[:error] = [AlertMessage.new(message: "Token Found and User Activated!")]
	    		redirect_to sign_in_path
    		else
		        flash[:error] = [AlertMessage.new(message: "Incorrect token, if you feel like this is wrong, feel free to contact us!")]
	    		redirect_to root_path
    		end
    	else
	        flash[:error] = [AlertMessage.new(message: "User not found!")]
    		redirect_to root_path
    	end
    end

end
