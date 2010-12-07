require 'spec_helper'
require 'support/active_record'

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
      Rake::Task.define_task(:environment)
    end
  
    after do
      FileUtils.rm_rf(destination)
    end

    it "should have copied the migration to the db/migrate folder" do
      rake_app["db:migrate"].invoke
      Dir.glob(File.join(File.expand_path("#{destination}/db/migrate"), "*_create_auditrails.rb")).should have_exactly(1).items
    end
  end

end
