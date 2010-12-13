require 'rails/generators'
require 'rails/generators/active_record'

module Auditrail
  module Generators
    class ModelGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", File.dirname(__FILE__))
      
      def prepare
        copy_file("audit_model.rb", File.join("app", "models", "audit.rb"))
      end
    end
  end
end