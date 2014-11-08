require 'rubygems'
require 'active_record'
require 'simplecov'
require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

SimpleCov.start do
  add_filter 'spec/'
end

require 'activerecord-after-transaction'

Dir[File.join(File.dirname(__FILE__), "support/**/*.rb")].each {|f| require f }

ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: ':memory:'

RSpec.configure do |c|
end

