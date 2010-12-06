require 'spec_helper'
require 'generators/migrations'
require 'fileutils'

describe Auditrail::Generators::MigrationsGenerator do
  context "migration" do
    subject { Auditrail::Generators::MigrationsGenerator }
    let(:destination) { File.expand_path("spec/tmp") }
  
    before do
      subject.start([] , :destination_root => destination)
    end
  
    after do
      FileUtils.rm_rf(destination)
    end

    it "blah" do
      Dir.glob(File.join(File.expand_path("#{destination}/db/migrate"), "*_create_auditrails.rb")).should have_exactly(1).items
    end
  end

end