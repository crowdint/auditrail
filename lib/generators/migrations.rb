require 'rails/generators'
require 'rails/generators/active_record'

module Auditrail
  module Generators
    class MigrationsGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", File.dirname(__FILE__))
      
      def prepare
        migrations_dir = File.join("db", "migrate")
        file_name = ::ActiveRecord::Generators::Base.next_migration_number(migrations_dir)
        copy_file("audits_table.rb", File.join(migrations_dir, "#{file_name.to_s}_create_audits.rb"))
      end
    end
  end
end