module API
	module V1
		class UsersController < ApplicationController
			before_action :authenticate

			def index

				success = JsonReturn.new(code: 1, message: "Hit Route", object: {message: "Success"})
				render json: success.as_json, status: 201
			end

			
			private
				#Authentication Methods - ALL CONTROLLERS
	  	  		def authenticate
		        	authenticate_basic_auth || render_unauthorized
		      	end
		      	def authenticate_basic_auth
		        	authenticate_or_request_with_http_token('User') do |token, options|
		          		#string = "#{username}:#{password}".force_encoding("ISO-8859-1").encode("UTF-8")
		        		@user = User.find_by(auth_token: token)
		        		return @user
		     		end
	  	  		end
		end
	end
end