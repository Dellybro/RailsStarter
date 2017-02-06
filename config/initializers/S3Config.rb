$BUCKETNAME = "holdthecourt-photos"

Aws.config.update({
  region: 'us-west-2',
  credentials: Aws::Credentials.new(ENV["HTC_ACCESS_KEY_ID"], ENV["HTC_SECRET_ACCESS_KEY"])
})

s3 = Aws::S3::Client.new(region: 'us-west-2', credentials: Aws::Credentials.new(ENV["HTC_ACCESS_KEY_ID"], ENV["HTC_SECRET_ACCESS_KEY"]) )
AWSHelper = AwsHelper.new({s3: s3, bucket: $BUCKETNAME}) 

