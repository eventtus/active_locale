require "bundler/setup"
require "active_locale"

ENV['RAILS_ENV'] = 'test'
require 'coveralls'
Coveralls.wear!

require 'rubygems'
require 'rspec'
require 'active_locale'

Bundler.require(:default)
# Connect to database
ActiveRecord::Base.establish_connection(adapter: 'postgresql',
                                        database: 'postgres')
I18n.config.available_locales = [:en, :es]

# Load our schema
# ActiveRecord::Base.logger = Logger.new(STDOUT)
load(File.join(File.dirname(__FILE__), 'schema.rb'))

# Define the testing model
class Page < ActiveRecord::Base
  translates :name
end

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run focus: true
  config.example_status_persistence_file_path = ".rspec_status"
  config.disable_monkey_patching!
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
