class Hoptoad < ActiveResource::Base
  self.site = HOPTOAD_SITE_URL

  class << self
    @@auth_token = HOPTOAD_AUTH_TOKEN

    def find(*arguments)
      arguments = append_auth_token_to_params(*arguments)
      super(*arguments)
    end

    def append_auth_token_to_params(*arguments)
      opts = arguments.last.is_a?(Hash) ? arguments.pop : {}
      opts = opts.has_key?(:params) ? opts : opts.merge(:params => {}) 
      opts[:params] = opts[:params].merge(:auth_token => @@auth_token)
      arguments << opts
      arguments
    end
  end
end

class Error < Hoptoad
end
