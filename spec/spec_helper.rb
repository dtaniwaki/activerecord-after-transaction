require 'rubygems'
#require 'database_cleaner'
require 'active_record'
require 'simplecov'
require "codeclimate-test-reporter"
CodeClimate::TestReporter.start
# require 'coveralls'
# Coveralls.wear!

SimpleCov.start do
  add_filter 'spec/'
end

Dir[File.join(File.dirname(__FILE__), "support/**/*.rb")].each {|f| require f }

ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: ':memory:'

RSpec.configure do |c|
  # c.before :suite do
  #   ActiveRecord::Migration.verbose = false
  #   DatabaseCleaner.clean_with :truncation
  # end
  # c.before :example do
  #   DatabaseCleaner.strategy = :truncation
  #   DatabaseCleaner.start
  # end
  # c.after :example do
  #   DatabaseCleaner.clean
  # end
end

