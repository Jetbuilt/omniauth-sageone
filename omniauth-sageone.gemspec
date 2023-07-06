# frozen_string_literal: true

require File.expand_path('lib/omniauth-sageone/version', __dir__)

Gem::Specification.new do |gem|
  gem.authors       = ['Jared Moody']
  gem.email         = ['jared@jetbuilt.com']
  gem.description   = 'OmniAuth strategy for SageOne.'
  gem.summary       = 'OmniAuth strategy for SageOne.'
  gem.homepage      = 'https://github.com/jetbuilt/omniauth-sageone'
  gem.licenses      = 'MIT'

  gem.files         = `git ls-files`.split("\n")
  gem.name          = 'omniauth-sageone'
  gem.require_paths = ['lib']
  gem.version       = OmniAuth::SageOne::VERSION

  gem.metadata['rubygems_mfa_required'] = 'true'

  gem.required_ruby_version = '>= 3.0'

  gem.add_dependency 'omniauth', '~> 2.0'
  gem.add_dependency 'omniauth-oauth2', '~> 1.0'
end
