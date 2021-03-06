CarrierWave.configure do |config|
  if Rails.env.test? # For testing, upload files to local `tmp` folder.
    config.enable_processing = false
    config.root = "#{Rails.root}/tmp/tests"
  else
    config.fog_provider = 'fog/aws'                                                   # required
    config.fog_credentials = {
      provider:              'AWS',                                                   # required
      aws_access_key_id:      Rails.application.secrets[:amazon_s3_access_key],       # required
      aws_secret_access_key:  Rails.application.secrets[:amazon_s3_secret_access_key] # required
      # region:                'eu-west-1',                   # optional, defaults to 'us-east-1'
      # host:                  's3.example.com',              # optional, defaults to nil
      # endpoint:              'https://s3.example.com:8080'  # optional, defaults to nil
    }
    config.fog_directory  = Rails.application.secrets[:amazon_s3_bucket] # required
    config.fog_public     = false                                            # optional, defaults to true
    config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" } # optional, defaults to {}
  end
end
