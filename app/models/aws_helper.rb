class AwsHelper
	attr_accessor :bucket, :resource, :presigner, :bucket_name, :s3

	def initialize(args)
		self.resource = Aws::S3::Resource.new(region:'us-west-2')
		self.presigner = Aws::S3::Presigner.new
		self.bucket = Aws::S3::Bucket.new(args[:bucket])
		self.bucket_name = args[:bucket]
		self.s3 = args[:s3]

	end

	def getObject(key)
		begin
			object = Aws::S3::Object.new(self.bucket_name, key, self.s3)
			object.exists? ? object : false
		rescue Exception => e
			puts e
			return false
		end
	end

	def putObject(file, key)
		begin
			File.open(file.path) do |file|
				self.bucket.put_object({body: file, key: key, :acl => "public-read"})
			end

			object = self.getObject(key)
			return object
		rescue Exception => e
			puts "FAILED PUTTING OBJECT IN BUCKET"
			puts e
			return false
		end
	end

	def removeObject(key)
		begin 
			object = self.getObject(key)
			object.delete

			return true
		rescue Exception => e
			puts e
			return false;
		end
	end

	def getURL(key)
		object = self.getObject(key)
		object.presigned_url(:get)
        
	end

end