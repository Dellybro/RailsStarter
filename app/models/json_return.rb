class JsonReturn
	# This class is mainly used on API return calls
	# Provide a code, a message and the object or objects
	# Ex. success =  JsonReturn.new(	code: 1, 
	#  									message: "message", 
	#									object: {:object_name => object(s) }
	#								)

	include ActiveModel::Validations
	include ActiveModel::Conversion
	extend ActiveModel::Naming

	attr_accessor :code, :message, :object

	validates_presence_of :code, :message

	def initialize(attributes = {})
		attributes.each do |name, value|
			if name.eql?(:code)
				self.code = value
			elsif name.eql?(:message)        
				self.message = value
			elsif name.eql?(:object)
				self.object = value
			end
		end
	end
  
end