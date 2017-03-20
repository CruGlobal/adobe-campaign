module Adobe
  module Campaign
    class << self
      attr_accessor :configuration
    end

    def self.configure
      self.configuration ||= Configuration.new
      yield(configuration)
    end

    class Configuration
      # Required. The issuer, your organization ID in the format org_ident@AdobeOrg.
      attr_accessor :org_id

      # Required. The subject, your API client account ID in the format: id@techacct.adobe.com.
      attr_accessor :tech_acct
      
      # Required. Api key retrieved from https://www.adobe.io/console/integrations
      attr_accessor :api_key
      
      attr_accessor :ims_host

      def initialize
        @org_id = ''
        @tech_acct = ''
        @api_key = ''
        @ims_host = 'ims-na1.adobelogin.com'
      end
    end
  end
end
