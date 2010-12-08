require 'spec_helper'
require 'yaml'
require 'support/active_record'

describe 'A test class' do
  
  subject { @test_class }
  
  context 'its class should be auditable' do
    it 'contains an auditable method' do
      subject.should respond_to(:auditable)
    end
  end

  context 'create a new object' do
    it "should" do
      instance = subject.new
      instance.name = "Text"
      instance.save
      audit_changes = @audit_class.first.dumped_changes
      changes_hash = YAML.load(audit_changes)
      changes_hash["name"][0].should eq(nil)
      changes_hash["name"][1].should eq("Text")
    end
  end
end
