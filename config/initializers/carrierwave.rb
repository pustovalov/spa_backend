CarrierWave.configure do |config|
  config.fog_provider = "fog/aws"
  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     "#{Rails.application.secrets.aws_access_key_id}",
    aws_secret_access_key: "#{Rails.application.secrets.aws_secret_access_key}",
  }
  config.fog_directory  = "#{Rails.application.secrets.s3_bucket_name}"
  config.fog_public     = false
  config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" }
end
