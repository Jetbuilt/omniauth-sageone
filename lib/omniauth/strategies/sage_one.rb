require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class SageOne < OmniAuth::Strategies::OAuth2
      option :client_options, {
        authorize_url: 'https://www.sageone.com/oauth2/auth',
        token_url: 'https://api.sageone.com/oauth2/token'
      }

      option :authorize_params, {
        response_type: 'code'
      }

      protected

      # Override this method to remove the query string from the callback_url because SageOne
      # requires an exact match
      def build_access_token
        verifier = request.params['code']
        client.auth_code.get_token(
          verifier,
          {
            redirect_uri: callback_url.split('?').first
          }.merge(token_params.to_hash(symbolize_keys: true)),
          deep_symbolize(options.auth_token_params)
        )
      end
    end
  end
end

OmniAuth.config.add_camelization 'sageone', 'SageOne'
