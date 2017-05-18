require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class SageOne < OmniAuth::Strategies::OAuth2
      TOKEN_URLS = {
        'ca' => 'https://mysageone.ca.sageone.com/oauth2/token',
        'de' => 'https://oauth.eu.sageone.com/token',
        'es' => 'https://oauth.eu.sageone.com/token',
        'fr' => 'https://oauth.eu.sageone.com/token',
        'gb' => 'https://app.sageone.com/oauth2/token',
        'ie' => 'https://app.sageone.com/oauth2/token',
        'us' => 'https://mysageone.na.sageone.com/oauth2/token'
      }.freeze

      option :client_options,
             authorize_url: 'https://www.sageone.com/oauth2/auth/central'

      option :authorize_params,
             response_type: 'code'

      uid do
        access_token['requested_by_id']
      end

      credentials do
        {
          resource_owner_id: access_token['resource_owner_id']
        }
      end

      info do
        {
          country: country
        }
      end

      # SageOne has different token endpoints for each available country. The country is returned in
      # the authorization callback. Configure the OAuth client to use that information.
      def client
        ::OAuth2::Client.new(options.client_id, options.client_secret, client_options)
      end

      protected

      # Override this method to remove the query string from the callback_url because SageOne
      # requires an exact match
      def build_access_token
        client.auth_code.get_token(
          request.params['code'],
          {
            redirect_uri: callback_url.split('?').first
          }.merge(token_params.to_hash(symbolize_keys: true)),
          deep_symbolize(options.auth_token_params)
        )
      end

      def country
        request[:country].try(:downcase)
      end

      def client_options
        hash = if country
                 { token_url: TOKEN_URLS[country] }.merge(options.client_options)
               else
                 options.client_options
               end

        deep_symbolize(hash)
      end
    end
  end
end

OmniAuth.config.add_camelization 'sageone', 'SageOne'
