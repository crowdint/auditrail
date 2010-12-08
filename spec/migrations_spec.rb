require 'spec_helper'
require 'support/active_record'

describe Auditrail::Generators::MigrationsGenerator do

  context "create an audit migration" do

    it "should have copied the migration to the db/migrate folder" do
      Dir.glob(File.join(File.expand_path("#{@destination}/db/migrate"), "*_create_audits.rb")).should have_exactly(1).items
    end

    it "auditrails table should exist" do
      @audit_class.table_exists?.should be(true)
    end
  end

end
