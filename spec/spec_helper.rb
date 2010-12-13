$:.unshift File.join(File.dirname(__FILE__))
$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'auditrail'
require 'generators/migrations'
require 'generators/model'
require 'rails'
require 'fileutils'
require 'rake'

ENV["RAILS_ENV"] = "test"
ENV["RAILS_ROOT"] = "tmp"
DESTINATION = File.expand_path(File.join("spec","tmp"))
ENV['SCHEMA'] = File.join(DESTINATION, "db", "schema.rb")

module Auditrail
  class Application < Rails::Application; end 
end
