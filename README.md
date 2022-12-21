# OmniAuth SageOne

[![Gem Version](https://badge.fury.io/rb/omniauth-sageone.svg)](https://badge.fury.io/rb/omniauth-sageone)
![CI](https://img.shields.io/github/actions/workflow/status/Jetbuilt/omniauth-sageone/ci.yml?branch=main)

This is an unofficial OmniAuth strategy for authenticating to SageOne. To use it, you'll need to sign up for a Sage One OAuth2 Application ID and Secret.

## Basic Usage

    use OmniAuth::Builder do
      provider :sageone, ENV['SAGE_CLIENT_ID'], ENV['SAGE_CLIENT_SECRET'], scope: 'full_access'
    end

    # Options for `scope` are either `readonly` or `full_access`.

## Auth Hash

The hash in `env['omniauth.auth']` will have the following information:

- in `credentials`:
  - `token`: The access token.
  - `refresh_token`: The refresh token. Use this to get a new token when the one in `token` has been expired.
  - `expires_at`: Timestamp that indicates when `token` will expire.
  - `expires`: `true`
  - `resource_owner_id`: An ID returned by Sage One when fetching the access token. You'll need that value for API v3
    for request signing and the `X-SITE` header that is required on API requests.
- in `info`:
  - `country`: The user's country.
- in `uid`: The `requested_by_id` returned by Sage One when fetching the token.

## See Also

https://developer.sageone.com has the Sage One API documentation.
