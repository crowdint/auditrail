require 'rails/generators'
require 'rails/generators/active_record'

module Auditrail
  module Generators
    class MigrationsGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", File.dirname(__FILE__))
      
      def prepare
        file_name = ::ActiveRecord::Generators::Base.next_migration_number("db/migrate")
        copy_file("audits_table.rb", "db/migrate/#{file_name.to_s}_create_audits.rb")
      end
    end
  end
end