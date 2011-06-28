hoptoad_api_config = 
  begin
    YAML::load(File.open(File.expand_path('config/hoptoad_api.yml')))
  rescue
    nil
  end
if hoptoad_api_config
  HOPTOAD_AUTH_TOKEN = hoptoad_api_config['hoptoad_api']['auth_token']
  HOPTOAD_SITE_URL = hoptoad_api_config['hoptoad_api']['site_url']
  ERROR_FREQUENCY_MINIMUM = hoptoad_api_config['hoptoad_api']['error_frequency_minimum']
  ERROR_EXPIRY_TIME_IN_MINUTES = hoptoad_api_config['hoptoad_api']['error_expiry_time_in_minutes']
end
