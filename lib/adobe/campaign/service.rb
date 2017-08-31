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
        post_request(service_subs_url, payload)
      end
    end
  end
end
