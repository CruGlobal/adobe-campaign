# frozen_string_literal: true
module Adobe
  module Campaign
    class Railtie < Rails::Railtie
      rake_tasks do
        load File.join(File.dirname(__FILE__), '../../tasks/adobe.rake')
      end
    end
  end
end
