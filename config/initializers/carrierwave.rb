CarrierWave.configure do |config|
  config.fog_credentials = {
    # Configuration for Amazon S3 should be made available through an Environment variable.
    # For local installations, export the env variable through the shell OR
    # if using Passenger, set an Apache environment variable.

    
    # Configuration for Amazon S3
    :provider              => 'AWS',
    :aws_access_key_id     => "AWSACESSID",
    :aws_secret_access_key => "AWSECRETKEY",
    :region                => "AWSREGION"
  }

  config.enable_processing = true
  # For testing, upload files to local `tmp` folder.
  if Rails.env.test? || Rails.env.cucumber?
    config.storage = :file
    config.root = "#{Rails.root}/tmp"
  else
    config.storage = :fog
  end

  config.cache_dir = "#{Rails.root}/tmp/uploads" # To let CarrierWave work on heroku

  config.fog_directory    = "Bucket_Name"

end