# frozen_string_literal: true
require 'rest-client'

require 'adobe/campaign/version'
require 'adobe/campaign/configuration'
require 'adobe/campaign/railtie' if defined? ::Rails::Railtie
require 'adobe/campaign/base'
require 'adobe/campaign/profile'

module Adobe
  module Campaign
  end
end
