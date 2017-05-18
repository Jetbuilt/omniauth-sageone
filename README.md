# OmniAuth SageOne

This is an unofficial OmniAuth strategy for authenticating to SageOne. To use it, you'll need to sign up for a Sage One OAuth2 Application ID and Secret.

## Basic Usage

    use OmniAuth::Builder do
      provider :sageone, ENV['SAGE_CLIENT_ID'], ENV['SAGE_CLIENT_SECRET'], scope: 'full_access'
    end

    Options for `scope` are either `readonly` or `full_access`.
