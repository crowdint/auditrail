require 'spec_helper'

describe Auditrail::Generators::ModelGenerator do
  include Auditrail::Test::ActiveRecord
  
  before { generate_model }
  
  after {clean_tmp_path}

  it "should generate the Audit model" do
    file = File.expand_path("#{DESTINATION}/app/models/audit.rb")
    File.exist?(file).should be(true)
  end 
end
