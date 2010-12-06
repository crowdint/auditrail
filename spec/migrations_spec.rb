require 'spec_helper'
require 'generators/migrations'

describe Auditrail::Generators::MigrationsGenerator do
  subject { Auditrail::Generators::MigrationsGenerator }
  let(:destination) { File.expand_path("spec/tmp") }
  
  before do
    subject.start([] , :destination_root => destination)
  end

  it "should generate a migration" do
    
  end

end