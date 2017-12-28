CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:              'AWS',                        # required
    aws_access_key_id:     'Your_AWS_Key',                        # required
    aws_secret_access_key: 'Your_AWS_secret_Key',                        # required
    region:                'Your_AWS_Region',                  # optional, defaults to 'us-east-1'
  }
  config.storage = :fog
  config.fog_directory  = 'bucket_name_and_folder_path'
  config.fog_public     = true                           # optional, defaults to true
  config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" } # optional, defaults to {}
end
