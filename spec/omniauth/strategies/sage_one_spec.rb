# frozen_string_literal: true

require 'spec_helper'

describe OmniAuth::Strategies::SageOne do
  let(:access_token) { instance_double(OAuth2::AccessToken, options: {}) }

  let(:sageone) { OmniAuth::Strategies::SageOne.new({}) }

  before { allow(sageone).to receive(:access_token).and_return(access_token) }

  describe 'client options' do
    subject(:client_options) { sageone.options.client_options }

    it 'has correct authorize url' do
      expect(client_options.authorize_url).to eq('https://www.sageone.com/oauth2/auth/central')
    end

    it 'has correct token url' do
      expect(client_options.token_url).to eq('https://oauth.accounting.sage.com/token')
    end
  end

  describe 'authorize params' do
    it 'contains the filter' do
      expect(sageone.options.authorize_params['filter']).to eq('apiv3.1')
    end
  end

  describe '#callback_url' do
    before do
      allow(sageone).to receive(:full_host).and_return('https://example.com')
      allow(sageone).to receive(:script_name).and_return('/sub_uri')
      allow(sageone).to receive(:query_string).and_return('?country=usa')
    end

    it 'does not contain the query string' do
      expect(sageone.callback_url).to eq('https://example.com/sub_uri/auth/sageone/callback')
    end
  end
end
