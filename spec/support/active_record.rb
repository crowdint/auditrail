require 'active_record'

module Auditrail
  module Test
    module ActiveRecord
      
      def migrate
        rake_app = Rake::Application.new
        Rake.application = rake_app
        Rake.application.rake_require File.join("active_record", "railties", "databases")
        Rake::Task.define_task(:environment)

        ::ActiveRecord::Migration.verbose = ENV["VERBOSE"] ? ENV["VERBOSE"] == "true" : true
        ::ActiveRecord::Migrator.migrate(File.join(DESTINATION, "db", "migrate"), ENV["VERSION"] ? ENV["VERSION"].to_i : nil)
        rake_app["db:migrate"].invoke if ::ActiveRecord::Base.schema_format == :ruby
        generate_model
        load File.join(DESTINATION, 'app', 'models', 'audit.rb')
        @audit_class = ::Audit
      end

      def connection_open
        #::ActiveRecord::Base.logger = Logger.new(STDOUT)
        ::ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
        ::ActiveRecord::Schema.define(:version => 1) do
          create_table :tests do |t|
            t.string :name
          end
          
          create_table :users do |t|
            t.string :name
            t.string :email
            t.integer :age
          end
        end
        
        @test_class = Object.const_set(:Test, Class.new(::ActiveRecord::Base))
        @user_class = Object.const_set(:User, Class.new(::ActiveRecord::Base))
      end

      def connection_close
        Object.send(:remove_const, :Test)
        Object.send(:remove_const, :User)
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
