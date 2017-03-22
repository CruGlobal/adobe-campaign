# frozen_string_literal: true
module Adobe
  module Campaign
    class Base
      def self.endpoint
        raise 'You can not call requests directly on Adobe::Campaign::Base'
      end

      def self.find(search_text)
        get_request("#{endpoint}/byText?text=#{search_text}")
      end

      def self.post(body)
        full_url = URI.join('https://mc.adobe.io/cru/campaign/', endpoint)
        resp = RestClient.post(full_url.to_s, body, headers: auth_headers)
        JSON.parse(resp.body)
      end

      def self.get_request(url)
        full_url = URI.join('https://mc.adobe.io/cru/campaign/', url)
        resp = RestClient::Request.execute(
          method: :get,
          url: full_url.to_s,
          headers: Adobe::Campaign::Base.auth_headers
        )
        JSON.parse(resp.body)
      end

      def self.auth_headers
        {
          'Authorization' => "Bearer #{access_token}",
          'X-Api-Key' => Adobe::Campaign.configuration.api_key
        }
      end

      def self.access_token
        as_url = "https://#{Adobe::Campaign.configuration.ims_host}/ims/exchange/jwt"
        as_payload = {
          client_id: Adobe::Campaign.configuration.api_key,
          client_secret: Adobe::Campaign.configuration.api_secret,
          jwt_token: Adobe::Campaign.configuration.signed_jwt
        }
        access_token_resp = RestClient.post(as_url, as_payload, {})
        JSON.parse(access_token_resp.body)['access_token']
      end
    end
  end
end
