# frozen_string_literal: true
require 'rest-client'

require 'adobe/campaign/version'
require 'adobe/campaign/configuration'
require 'adobe/campaign/railtie' if defined? ::Rails::Railtie

module Adobe
  module Campaign
    class Profile
      def self.find(search_text)
        get_request("profileAndServices/profile/byText?text=#{search_text}")
      end

      def self.post(body)
        post_request('profileAndServices/profile', body)
      end

      def self.get_request(url)
        full_url = URI.join('https://mc.adobe.io/cru/campaign/', url)
        resp = RestClient.get(full_url, headers: auth_headers)
        JSON.parse(resp.body)
      end

      def self.post_request(url, body)
        full_url = URI.join('https://mc.adobe.io/cru/campaign/', url)
        resp = RestClient.post(full_url, body, headers: auth_headers)
        JSON.parse(resp.body)
      end

      def self.auth_headers
        {
          'Authorization' => "Bearer #{Adobe::Compaign.configuration.signed_jwt}",
          'X-Api-Key' => Adobe::Compaign.configuration.api_key
        }
      end
    end
  end
end
