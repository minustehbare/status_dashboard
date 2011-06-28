newrelic_api_config = YAML::load(File.open(File.expand_path('config/newrelic_api.yml')))
NEWRELIC_API_KEY = newrelic_api_config['newrelic_api']['api_key']
NEWRELIC_ACCOUNT_ID = newrelic_api_config['newrelic_api']['account_id']
