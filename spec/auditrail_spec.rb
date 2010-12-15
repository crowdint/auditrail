require 'spec_helper'
require 'yaml'
require 'support/active_record'

describe 'A test class' do
  include Auditrail::Test::ActiveRecord

  before do
    connection_open
    generate_migration
    migrate

    # the blocked passed to auditable will determine the action invoker
    # that will be serialized
    @test_class.class_eval do
      auditable do
        # When using the options by_user you can also pass the parameters as a block.
        # by_user 465
        # or
        # by_user do
        #  465
        # end

        by_user 465
      end
    end
  end

  after do
    clean_tmp_path
    connection_close
  end

  context 'its class should be auditable' do
    it 'contains an auditable method' do
      @test_class.should respond_to(:auditable)
    end
  end

  context 'basic Audit behavior' do
    
    before do
      @test_class.create(:name => "Text")
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

  context "basic query content behavior" do

    before do
      @user_class.class_eval do
        auditable
      end
      10.times do
        @test_class.create(:name => "Text")
      end

      5.times do |item_number|
        @user_class.create(:name => "User #{item_number}", :age => 15 + item_number, :email => "abc#{item_number}@abc.com")
      end
    end

    it "should find the audits by model" do
      @audit_class.model_filter(:user).should have_exactly(5).items
      @audit_class.model_filter(:test).should have_exactly(10).items
      @audit_class.model_filter(:admin).should have_exactly(0).items
    end

    it "should find the audits by action" do
      5.times do |item_number|
        test = @test_class.first
        test.name = "Text changed #{item_number}"
        test.save
      end

      3.times do |item_number|
        user = @user_class.first
        user.name = "User 1 name changed #{item_number}"
        user.save
      end

      @audit_class.action_filter(:creating).should have_exactly(15).items
      @audit_class.action_filter(:updating).should have_exactly(8).items
      @audit_class.action_filter(:other).should have_exactly(0).items
    end
  end

  context "track changes only for selected attributes" do
    before do
      @user_class.class_eval do
        auditable do
          for_attributes "name", "email"
        end
      end
      @user_class.create(:name => "Marco", :age => 15, :email => "marco@abc.com")
    end

    it "should track only for name and email" do
      user = @user_class.first
      user.name = "Polo"
      user.save

      user = @user_class.first
      user.email = "polo@abc.com"
      user.save

      @audit_class.all.should have_exactly(3).items
    end

    it "should not track changes for age" do
      user = @user_class.first
      user.age = 16
      user.save

      @audit_class.all.should have_exactly(1).items
    end
  end
end
