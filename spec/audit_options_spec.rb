require 'spec_helper'

describe Auditrail::ClassMethods::AuditOptions do
  before {Object.const_set(:AuditOptions, Class.new(Auditrail::ClassMethods::AuditOptions))}
  
  context 'methods' do
    before {@audit_options = AuditOptions.new}
    
    it 'should contain a method to obtain a user' do
      @audit_options.should respond_to(:user)
    end
    
    it 'should contain a method to obtain a attributes' do
      @audit_options.should respond_to(:attributes)
    end
  end

  it 'should accept a block as aparameter'
end