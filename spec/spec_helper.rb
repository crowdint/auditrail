$:.unshift File.join(File.dirname(__FILE__))
$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'auditrail'
require 'generators/migrations'
require 'rails'
require 'fileutils'
require 'rake'

ENV["RAILS_ENV"] = "test"
module Rails3JQueryAutocomplete
  class Application < Rails::Application; end 
end

