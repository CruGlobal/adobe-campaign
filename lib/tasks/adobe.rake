# frozen_string_literal: true
# rubocop:disable Metrics/BlockLength
require 'jwt'
require 'adobe/campaign'

namespace :adobe do
  desc 'Generate a long-life JWT for exchanging with the adobelogic server'
  task :generate_jwt do
    unless ENV['key']
      puts 'You must include a reference to the private key'
      puts 'example: rake adobe:generate_jwt key=~/certs/adobe/private.key'
      exit 1
    end

    key_path = File.expand_path(ENV['key'])
    unless File.exist? key_path
      puts 'private key does not exist!'
      exit 1
    end

    org_id = Adobe::Campaign.configuration.org_id
    tech_acct = Adobe::Campaign.configuration.tech_acct
    api_key = Adobe::Campaign.configuration.api_key
    ims_host = Adobe::Campaign.configuration.ims_host
    payload = {
      'exp' => 1.year.from_now.to_time.to_i,
      'iss' => "#{org_id}@AdobeOrg",
      'sub' => "#{tech_acct}@techacct.adobe.com",
      'aud' => "https://#{ims_host}/c/#{api_key}",
      "https://#{ims_host}/s/ent_campaign_sdk" => true
    }
    priv_key = OpenSSL::PKey::RSA.new(File.read(key_path))
    signed_jwt = JWT.encode(payload, priv_key, 'RS256')
    puts 'Your new signed JWT:'
    puts signed_jwt
    puts "It will expire: #{10.years.from_now}"
  end
end
