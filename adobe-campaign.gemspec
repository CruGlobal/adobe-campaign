# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'adobe/campaign/version'

Gem::Specification.new do |spec|
  spec.name          = 'adobe-campaign'
  spec.version       = Adobe::Campaign::VERSION
  spec.authors       = ['Spencer Oberstadt']
  spec.email         = ['soberstadt@gmail.com']

  spec.summary       = 'A ruby wrapper for connecting your Rails app with Adobe Campaign.'
  spec.homepage      = 'https://github.com/soberstadt/adobe-campaign'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'activesupport', '>= 3.1.0'
  spec.add_runtime_dependency 'jwt', '~> 1.0'
  spec.add_runtime_dependency 'rails', '>= 3.1'
  spec.add_runtime_dependency 'rest-client', '>= 1.6.0'

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'guard-rubocop'
  spec.add_development_dependency 'rake', '>= 12.3.3'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.71.0'
end
