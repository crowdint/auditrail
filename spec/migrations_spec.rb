require 'spec_helper'
require 'support/active_record'

describe Auditrail::Generators::MigrationsGenerator do

  context "creating an audit migration" do

    it "should have copied the migration to the db/migrate folder" do
      Dir.glob(File.join(File.expand_path("#{@destination}/db/migrate"), "*_create_audits.rb")).should have_exactly(1).items
    end

    it "should create an auditrails table" do
      @audit_class.table_exists?.should be(true)
    end
    
    it "should have fields" do
    end
  end
end
