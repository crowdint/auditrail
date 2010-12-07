require 'spec_helper'
require 'support/active_record'

#ENV['SCHEMA'] = "spec/tmp/db/schema.rb"

describe Auditrail::Generators::MigrationsGenerator do

  context "create an audit migration" do

    subject { Auditrail::Generators::MigrationsGenerator }
    let(:destination) { File.expand_path("spec/tmp") }
    let(:rake_app) { Rake::Application.new } 
  
    before do
      new_method = subject.method(:new)
      subject.stub!(:new).and_return do |*args|
        gen = new_method.call(*args)
        gen.stub(:migrate)
        gen
      end

      subject.start([] , :destination_root => destination)

      Rake.application = rake_app
      Rake.application.rake_require "active_record/railties/databases"
      Rake.application.rake_require "rails/tasks/misc"
      Rake::Task.define_task(:environment)
      
      rake_app["db:create"].invoke
      rake_app["db:migrate"].invoke
    end
  
    after do
      FileUtils.rm_rf(destination)
    end
    
    it "should have copied the migration to the db/migrate folder" do
      Dir.glob(File.join(File.expand_path("#{destination}/db/migrate"), "*_create_audits.rb")).should have_exactly(1).items
    end
    
    it "auditrails table should exist" do
      audit_class = Object.const_set(:Audit, Class.new(::ActiveRecord::Base))
      audit_class.table_exists?.should be(true)
      Object.send(:remove_const, :Audit)
      
    end
  end
  
  private
    def fake_rails_root
      File.join(File.dirname(__FILE__), 'rails_root')
    end
end
