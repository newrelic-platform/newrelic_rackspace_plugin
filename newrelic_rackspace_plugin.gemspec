$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__)) + '/lib/'
require 'newrelic_rackspace_plugin/version'
Gem::Specification.new do |s|
  s.name = 'newrelic_rackspace_plugin'
  s.version = NewRelicRackspacePlugin::VERSION.version
  s.summary = 'Rackspace plugin base'
  s.author = 'New Relic'
  s.description = 'Rackspace plugin base'
  s.require_path = 'lib'
  s.add_dependency 'newrelic_plugin'
  s.add_dependency 'fog'
  s.files = Dir['**/*']
end
