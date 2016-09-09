class Picture < ActiveRecord::Base
	before_create :set_objectId

	# Uploader is used Via Carrierwave to upload images straight to AWS
	mount_uploader :uploader, PhotosUploader

	#Polymorphic assoication, a picture can be attached to any model using the following snippet
		#has_many :pictures, :as => :imageable
	belongs_to :imageable, polymorphic: true

	# Order it comes back from the database. First picture is the latest picture created.
	default_scope {order("created_at DESC")}


	# Custom remove methods help remove all other models in association if needed.
	def remove
		self.remove_uploader!
		self.delete
	end

	private	
		# ObjectID of the picture can be set
		# Rails convention sets an id starting at 0. Providing an ObjectID for URL parameters allows for more control
		def set_objectId
			return if objectId.present?
			self.objectId = generate_token("objectId")
		end

		def generate_token(attribute)
			loop do
				token = SecureRandom.hex
				break token unless self.class.exists?("#{attribute}": token)
			end
		end
	
end
