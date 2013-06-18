# Rackspace plugin library
This library is used by the following New Relic plugins:
- [Load Balancers](https://github.com/newrelic-platform/newrelic_rackspace_load_balancers_plugin)

## Dependencies
* Ruby
* Bundler `gem install bundler`

## Usage
1. Create a Gemfile within desired directory
2. Add entry for any rackspace plugin to include
3. Run `bundle install --binstubs`
4. Run `./bin/newrelic_rs --sample-config`
5. Edit `config/newrelic_plugin.yml` and replace "LICENSE_KEY" with your New Relic license key
6. Run `./bin/newrelic_rs`
