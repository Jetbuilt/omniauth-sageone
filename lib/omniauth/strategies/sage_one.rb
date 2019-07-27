require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class SageOne < OmniAuth::Strategies::OAuth2

      option :client_options,
             authorize_url: 'https://www.sageone.com/oauth2/auth/central'

      option :authorize_params,
             response_type: 'code',
             filter: 'apiv3.1'

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
      # the authorization callback. Configure the OAuth client to use that information by
      # customizing the client options
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
        request.env ? request[:country].try(:downcase) : options.client_options[:country]
      end

      # Override client_options[:token_url] using the country from ether the request or the
      # provided country option
      def client_options
        options.client_options[:token_url] = 'https://oauth.accounting.sage.com/token'
        deep_symbolize(options.client_options)
      end
    end
  end
end

OmniAuth.config.add_camelization 'sageone', 'SageOne'
