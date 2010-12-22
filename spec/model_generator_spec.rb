require 'spec_helper'
require 'support/active_record'

describe Auditrail::Generators::ModelGenerator do
  include Auditrail::Test::ActiveRecord
  
  before { generate_model }
  
  after {clean_tmp_path}

  it "should generate the Audit model" do
    file = File.expand_path(File.join(DESTINATION, "app", "models", "audit.rb"))
    File.exist?(file).should be(true)
  end 
end
