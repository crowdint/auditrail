require 'spec_helper'
require 'yaml'
require 'support/active_record'

describe 'A test class' do
  include Auditrail::Test::ActiveRecord

  before do
    connection_open
  end
  
  after do
    connection_close
  end

  context 'its class should be auditable' do
    it 'contains an auditable method' do
      @test_class.should respond_to(:auditable)
    end
  end

  context '' do

    before do
      generate_migration
      migrate
      instance = @test_class.new
      instance.name = "Text"
      instance.save

      # the blocked passed to auditable will determine the action invoker
      # that will be serialized
      @test_class.send(:auditable) do
        465
      end

    end

    after do
      clean_tmp_path
    end

    context 'creates a new object' do

      it "should track the changes in the Test object" do
        audit_changes = @audit_class.first.dumped_changes
        changes_hash = YAML.load(audit_changes)
        changes_hash["name"][0].should eq(nil)
        changes_hash["name"][1].should eq("Text")
      end
      
      it "should receive a creating status" do
        @audit_class.first.action.should eq("creating")
      end

      it "should save the model name of the audited object" do
        @audit_class.first.model_changed.should eq("Test")
      end

      it 'should save the id of the original affected object' do
        instance = @test_class.first
        @audit_class.first.element_id.should eq(instance.id)
      end

      it 'should return the action invoker' do
        @audit_class.first.action_invoker.should eq(465)
      end

    end
    
    context 'updates an existing object' do
      it "should receive a creating status" do
        instance = @test_class.first
        instance.name = "Text change"
        instance.save
        @audit_class.last.action.should eq("updating")
      end
    end 

  end
end
