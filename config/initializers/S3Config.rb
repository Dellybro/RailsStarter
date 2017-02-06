$BUCKETNAME = "photos"

Aws.config.update({
  region: 'us-west-2',
  credentials: Aws::Credentials.new(ENV["ACCESS_KEY_ID"], ENV["SECRET_ACCESS_KEY"])
})

s3 = Aws::S3::Client.new(region: 'us-west-2', credentials: Aws::Credentials.new(ENV["ACCESS_KEY_ID"], ENV["SECRET_ACCESS_KEY"]) )
AWSHelper = AwsHelper.new({s3: s3, bucket: $BUCKETNAME}) 

