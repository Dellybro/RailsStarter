class AlertMessage
	# Alert Messages are used for on page alerts or can be sent to an Iphone/Android and handled appropriately
	# Used in cahoots with flash[:warning] or flash[:success] etc
	include ActiveModel::Validations
	include ActiveModel::Conversion
	extend ActiveModel::Naming


	attr_accessor :message_title, :message, :object, :code

	def initialize(attributes = {})
		attributes.each do |name, value|
			if name.eql?(:code)
				self.code = value
			elsif name.eql?(:message)        
				self.message = value
			elsif name.eql?(:object)
				self.object = value
			elsif name.eql?(:message_title)
				self.message_title = value
			end
		end
	end
  
end