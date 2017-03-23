# frozen_string_literal: true
module Adobe
  module Campaign
    class Base
      class << self
        def endpoint
          raise 'You can not call requests directly on Adobe::Campaign::Base'
        end

        def all
          get_request(endpoint)
        end

        def find(search_text)
          get_request("#{endpoint}/byText?text=#{search_text}")
        end

        def post(body)
          post_request(endpoint, body)
        end

        def get_request(url)
          full_url = url_prefix(url)
          resp = RestClient::Request.execute(
            method: :get,
            url: full_url,
            headers: Adobe::Campaign::Base.auth_headers
          )
          JSON.parse(resp.body)
        end

        def post_request(url, body)
          full_url = url_prefix(url)
          json = body.is_a?(String) ? body : body.to_json
          resp = RestClient.post(full_url, json, auth_headers.merge('Content-Type' => 'application/json'))
          JSON.parse(resp.body)
        end

        def auth_headers
          {
            'Authorization' => "Bearer #{access_token}",
            'X-Api-Key' => Adobe::Campaign.configuration.api_key
          }
        end

        def access_token
          Adobe::Campaign::Base.load_access_token
        end

        def load_access_token
          return @access_token if @access_token && @access_token_expires > Time.zone.now
          as_url = "https://#{Adobe::Campaign.configuration.ims_host}/ims/exchange/jwt"
          as_payload = {
            client_id: Adobe::Campaign.configuration.api_key,
            client_secret: Adobe::Campaign.configuration.api_secret,
            jwt_token: Adobe::Campaign.configuration.signed_jwt
          }
          access_token_resp = RestClient.post(as_url, as_payload, {})
          json = JSON.parse(access_token_resp.body)
          @access_token_expires = 1439.minutes.from_now
          @access_token = json.dig('access_token')
        end

        protected

        def url_prefix(url)
          url.starts_with?('http') ? url : url_join('https://mc.adobe.io/cru/campaign/', url)
        end

        def url_join(*args)
          base = args.map { |arg| arg.gsub(%r{^/*(.*?)/*$}, '\1') }.join('/')
          args.last.ends_with?('/') ? "#{base}/" : base
        end
      end
    end
  end
end
