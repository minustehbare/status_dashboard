hoptoad_api_config = 
  begin
    hoptoad_api_config = YAML::load(File.open(File.expand_path('config/hoptoad_api.yml')))
  rescue
    nil
  end
if hoptoad_api_config
  HOPTOAD_AUTH_TOKEN = hoptoad_api_config['hoptoad_api']['auth_token']
  HOPTOAD_SITE_URL = hoptoad_api_config['hoptoad_api']['site_url']
  ERROR_FREQUENCY_MINIMUM = hoptoad_api_config['hoptoad_api']['error_frequency_minimum']
end
