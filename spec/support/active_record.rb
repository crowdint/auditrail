require 'active_record'

module Auditrail
  module Test
    module ActiveRecord
      
      DESTINATION = File.expand_path("spec/tmp")

      def migrate
        rake_app = Rake::Application.new
        Rake.application = rake_app
        Rake.application.rake_require "active_record/railties/databases"
        Rake::Task.define_task(:environment)

        ::ActiveRecord::Migration.verbose = ENV["VERBOSE"] ? ENV["VERBOSE"] == "true" : true
        ::ActiveRecord::Migrator.migrate("spec/tmp/db/migrate/", ENV["VERSION"] ? ENV["VERSION"].to_i : nil)
        rake_app["db:migrate"].invoke if ::ActiveRecord::Base.schema_format == :ruby
        
        @audit_class = Object.const_set(:Audit, Class.new(::ActiveRecord::Base))
      end

      def connection_open
        ::ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
        ::ActiveRecord::Schema.define(:version => 1) do
          create_table :tests do |t|
            t.column :name, :string
          end
        end
        
        @test_class = Object.const_set(:Test, Class.new(::ActiveRecord::Base))
        @test_class.send(:auditable)
      end 

      def connection_close
        Object.send(:remove_const, :Audit) if @audit_class
        Object.send(:remove_const, :Test)
        ::ActiveRecord::Base.connection.tables.each do |table|
          ::ActiveRecord::Base.connection.drop_table(table)
        end
      end 

      def clean_tmp_path
        FileUtils.rm_rf(DESTINATION)
      end
      
      def generate_migration
        Auditrail::Generators::MigrationsGenerator.start([] , :destination_root => DESTINATION)
      end
      
      def generate_model
        Auditrail::Generators::ModelGenerator.start([] , :destination_root => DESTINATION)
      end

    end
  end
end
