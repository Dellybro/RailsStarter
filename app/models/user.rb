class User < ActiveRecord::Base


	# Validation methods
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
	validates :password, confirmation: true, length: { minimum: 6},
    		unless: Proc.new { |user| user.password.blank? }

    # Before the object is written to MYSQL, allows for multiple thing to happen
    before_create :set_auth_token, :set_objectId, :downcase_email
    # Any models needing immediate assocation after creation, Ex. Settings/Pictures
    after_create :setup_models

    # Polymorphic association with pictures
    has_many :pictures, as: :imageable

    # Bcrypt passwords
	has_secure_password

	# Tokens are stored until the object is deallocated, the token is hashed and applied to the respecting variable.
	# A token is usually sent in the email parameters, than checked against the respecting variables hash
	attr_accessor :reset_token, :remember_token, :activation_token


	# Settings model eventually
	has_one :setting

	# Authenticate the users login
	def User.authenticate(username, password)
		User.find_by(email: username).try(:authenticate, password)
	end

	# Creates New Token, digests the token and sets it as activation_digest # Than finally Sends email. #
	def sendActivationLink
		self.activation_token = User.new_token
		update_attribute(:activation_digest, User.digest(self.activation_token))
		UsersMailer.account_activation(self).deliver_now
	end
	# Quick easy method to actiate the user.
	def activate
		update_attribute(:activated, true)
    	update_attribute(:activated_at, Time.zone.now)
	end

	# Crypt tokens and hash them.
	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
		                                         BCrypt::Engine.cost
		BCrypt::Password.create(string, :cost => cost)
	end

	
	#returns a random token for persistent login
	def User.new_token
		SecureRandom.urlsafe_base64
	end

	# Create a reset digest for the user and update attributes on spot.
	def create_reset_digest
		self.reset_token = User.new_token
		update_attribute(:reset_digest, User.digest(reset_token))
		update_attribute(:reset_sent_at, Time.zone.now)
	end

	# Sends password reset email using UserMailer found in /app/mailers/user_mailer.rb
	def send_password_reset_email
		self.create_reset_digest
		UsersMailer.password_reset(self).deliver_now
	end

	# Checks for reset password sent
	def password_reset_expired?
		reset_sent_at < 2.hours.ago
	end

	# Hash the remmeber token using bcrypt so it can not be stolen
	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end

	# If the user is authenticated using a digest method. Checks against bcrypt
	def authenticated?(attribute, token)
		digest = self.send("#{attribute}_digest")
		return false if digest.nil?
		password = BCrypt::Password.new(digest)
		password == token ? true : false
	end

	# Updates remember digest to nil, easy to call user.forget
	def forget
		update_attribute(:remember_digest, nil)
	end

	# Removes the user, any other models needing removal should be added here
	# Models should conform to a remove method. object.remove
	def remove
		begin
			# Remove pictures, this method gets rid of all pictures currently on the User
			remove_pictures
			self.setting.delete
			self.delete
			return true
		rescue Exception => e
			puts e
			return false
	  	end 
	end

	private
	
		# Removes all pictures by removing the uploader first, which will remove the picture from AWS
		#This will break if AWS Bucket is not found. What will break specifically is "Remove_Uploader!",
		#This attemps to remove an image from the AWS bucket. Using begin/rescue, is basically like try-catch, incase it does break
		def remove_pictures
			begin 
				self.pictures.each do |picture|
					picture.remove_uploader!
					picture.delete
				end
				# Bucket found and images removed
				return true
			rescue Exception => e
				# No Bucket found
				return false
			end
		end

		# Sets an auth token
		def set_auth_token
			return if auth_token.present?
			self.auth_token = generate_token("auth_token",2)
		end
		# Sets an objectID
		def set_objectId
			return if objectId.present?
			self.objectId = generate_token("objectId",1)
		end

		# Generates a token and checks against the variable name that one doesnt already exist for this class
		# Can be updated to generate different types
		# Currently if type is equal to one we want a UUID for objectID, if not than just generate a normal hex
		def generate_token(attribute, type)
			loop do
				if type == 1
					token = SecureRandom.uuid
				else
					token = SecureRandom.hex
				end
				break token unless self.class.exists?("#{attribute}": token)
			end
		end

		# Set up and models that need to be on the user before created
		def setup_models

			self.setting = Setting.new
			#Create the initial picture of index 1
			self.pictures.create(:picture_index => 1)
		end

		# Downcase the email beforesaving.
		def downcase_email
			self.email = self.email.downcase
		end
end
