# frozen_string_literal: true
module Adobe
  module Campaign
    class Service < Adobe::Campaign::Base
      def self.endpoint
        'profileAndServices/service'
      end

      def self.post_subscription(service_subs_url, person_pkey)
        payload = {
          'subscriber' => {
            'PKey' => person_pkey
          }
        }
        resp = RestClient.post(service_subs_url,
                               payload.to_json,
                               auth_headers.merge('Content-Type' => 'application/json'))
        JSON.parse(resp.body)
      end
    end
  end
end
