require 'active_record'

class Auditrail::Generators::MigrationsGenerator
  def migrate
    rake_app = Rake::Application.new
    Rake.application = rake_app
    Rake.application.rake_require "active_record/railties/databases"
    Rake::Task.define_task(:environment)

    ActiveRecord::Migration.verbose = ENV["VERBOSE"] ? ENV["VERBOSE"] == "true" : true
    ActiveRecord::Migrator.migrate("spec/tmp/db/migrate/", ENV["VERSION"] ? ENV["VERSION"].to_i : nil)
    rake_app["db:migrate"].invoke if ActiveRecord::Base.schema_format == :ruby
  end
end

RSpec.configure do |config|
  config.before(:all) do
    ::ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
    ::ActiveRecord::Schema.define(:version => 1) do
      create_table :tests do |t|
        t.column :name, :string
      end
    end
    
    @test_class = Object.const_set(:Test, Class.new(ActiveRecord::Base))
    @test_class.send(:auditable)
    @audit_class = Object.const_set(:Audit, Class.new(::ActiveRecord::Base))
    @destination = File.expand_path("spec/tmp")
    
    Auditrail::Generators::MigrationsGenerator.start([] , :destination_root => @destination)
  end 

  config.after(:all) do
    Object.send(:remove_const, :Test)
    Object.send(:remove_const, :Audit)
    ::ActiveRecord::Base.connection.tables.each do |table|
      ::ActiveRecord::Base.connection.drop_table(table)
    end
    FileUtils.rm_rf(@destination)
  end 

end
