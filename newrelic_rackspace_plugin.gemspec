$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__)) + '/lib/'
require 'newrelic_rackspace_plugin/version'
Gem::Specification.new do |s|
  s.name = 'newrelic_rackspace_plugin'
  s.version = NewRelicRackspacePlugin::VERSION.version
  s.summary = 'Rackspace plugin base'
  s.author = 'New Relic'
  s.description = 'Rackspace plugin base'
  s.require_path = 'lib'
  s.executables << 'newrelic_rs'
  s.add_dependency 'newrelic_plugin', '~> 1.3.0'
  s.add_dependency 'fog'
  s.add_dependency 'nokogiri',  '~> 1.5.0'
  s.add_dependency 'mime-types', '~> 1.16.0'
  s.files = Dir['**/*']
end
