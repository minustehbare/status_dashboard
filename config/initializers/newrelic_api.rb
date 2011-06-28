newrelic_api_config = 
  begin
    YAML::load(File.open(File.expand_path('config/newrelic_api.yml')))
  rescue
    nil
  end
if newrelic_api_config
  NEWRELIC_API_KEY = newrelic_api_config['newrelic_api']['api_key']
  NEWRELIC_ACCOUNT_ID = newrelic_api_config['newrelic_api']['account_id']
end
