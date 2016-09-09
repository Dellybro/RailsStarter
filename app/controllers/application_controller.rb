class ApplicationController < ActionController::Base
  	# Prevent CSRF attacks by raising an exception.
  	# For APIs, you may want to use :null_session instead.
	include UsersHelper
  	protect_from_forgery with: :exception

  	def get_error(object)
	    error_str = ""

	    object.errors.each{|attr, msg|           
	        error_str += "#{attr} - #{msg}\n"
	    }
	    error_str
	end

	# Will return X number of AlertMessage Models in an array for flash warning.
	def get_toastr_errors(object)
		err_array = Array.new
		object.errors.each{|attr, msg|
			err_array << AlertMessage.new(:message_title => "#{attr.to_s.tr("_"," ").capitalize}", :message => "#{msg}")
		}
		return err_array
	end

	# Logged in user route.
	def logged_in_user
		unless logged_in_user?
			store_location
			flash[:error] = [AlertMessage.new(message: "Oops Please log in.")]
			redirect_to sign_in_path
		end
	end

	# Page not found pretty standard
	def page_not_found
	    respond_to do |format|
	        format.html {
	          redirect_to server_error_path
	        }
	        format.json {
			      json = JsonReturn.new(:code => 241, :message => "Wrong URL or HTTP method", :object => params)    
			      render :json => json.to_json, :status => 201
	        }
		end
	end

	# Unauthorized redirect
	def render_unauthorized
		#self.headers['WWW-Authenticate'] =  'Basic realm="Users"'
		respond_to do |format|
	        format.html {
	          redirect_to server_error_path
	        }
	        format.json {
				error = JsonReturn.new(:code => 13, :message => "Unauthorized, GTFO", :object => "")
				render :json => error.as_json, :status => 420
	        }
		end
	end
end
