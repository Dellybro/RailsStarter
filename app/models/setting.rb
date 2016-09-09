class Setting < ActiveRecord::Base
	# Indexing has never been so much better!
	before_create :set_objectId


	# Rails asssocation allows a model to "belong to" one object, or multiple objects(Allowing for multiple object makes it a bridging assocation between various models)
	belongs_to :user


	private
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
