require 'newrelic_plugin'
require 'fog'

module NewRelicRackspacePlugin
  class PluginAgent < NewRelic::Plugin::Agent::Base

    attr_reader :connection, :options
    
    def initialize(*args)
      super
    end

    def agent_name
      self.class.name.split('::').last.downcase
    end

    def agent_options
      unless(@agent_options)
        @agent_options = NewRelic::Plugin::Config.config.options
        unless((rs = @agent_options['rackspace']).is_a?(Hash) && rs['username'] && rs['api_key'])
          raise NewRelic::Plugin::BadConfig.new('Missing Rackspace credentials')
        end
      end
      @agent_options
    end

    def setup_metrics
      require 'fog'
      @options = NewRelic::Plugin::Config.config.newrelic
      @connection = NewRelic::Plugin::NewRelicConnection.new(options)
    end

    def poll
      options['poll'] || 10
    end

    def report_metric(component, *args)
      opts = args.detect{|a| a.is_a?(Hash)}
      args.delete(opts) if opts
      comps = [component]
      comps << "#{opts[:name]}/#{component}" if opts[:name] && !opts[:disable_overview]
      comps.each do |component_name|
        super(component_name, *args)
      end
    end

    def fog(type)
      stype = type.to_sym
      require 'fog' unless @fog
      @fog ||= {}
      unless(@fog[stype])
        args = {
          :rackspace_username => agent_options['rackspace']['username'],
          :rackspace_api_key => agent_options['rackspace']['api_key']
        }
        if(agent_options['rackspace']['region'])
          args[:rackspace_region] = agent_options['rackspace']['region']
        end
        case stype
        when :compute
          klass = Fog::Compute::RackspaceV2
          args[:enpoint] = ''
        when :blockstorage
          klass = Fog::Rackspace::BlockStorage
          args[:endpoint] = ''
        when :storage
          klass = Fog::Storage::Rackspace
        when :loadbalancers
          klass = Fog::Rackspace::LoadBalancers
        when :databases
          klass = Fog::Rackspace::Databases
        when :cdn
          klass = Fog
        when :dns
          klass = Fog
        else
          raise ArgumentError.new "Invalid fog connection type received: #{type}"
        end
        @fog[stype] = klass.new(args)
      end
      @fog[stype]
    end
  end
end
