require 'jwt'
require 'adobe/campaign'

namespace :adobe do
  desc 'Generate a long-life JWT for exchanging with the adobelogic server'
  task :generate_jwt do

    org_id = Adobe::Campaign.configuration.org_id
    tech_acct = Adobe::Campaign.configuration.tech_acct
    api_key = Adobe::Campaign.configuration.api_key
    ims_host = Adobe::Campaign.configuration.ims_host
    payload = {
      'exp' => 1.year.from_now.to_time.to_i,
      'iss' => org_id,
      'sub' => tech_acct,
      'aud' => "https://#{ims_host}/c/#{api_key}",
      "https://#{ims_host}/s/ent_campaign_sdk" => true
    }
    priv_key = OpenSSL::PKey::RSA.new(File.read('private.key'))
    signed_jwt = JWT.encode(payload, priv_key, 'RS256')
    print "Your new signed JWT: #{signed_jwt}"
  end
end
