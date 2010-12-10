require 'spec_helper'
require 'support/active_record'

describe Auditrail::Generators::MigrationsGenerator do
  include Auditrail::Test::ActiveRecord
  
  before {generate_migration}
  
  after {clean_tmp_path}
  
  it "should generate the migration for the audits tabble into the db/migrate folder" do
    Dir.glob(File.join(File.expand_path("#{DESTINATION}/db/migrate"), "*_create_audits.rb")).should have_exactly(1).items
  end
end
