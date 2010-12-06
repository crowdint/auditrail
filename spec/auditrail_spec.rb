require 'spec_helper'
class TestModel < ActiveRecord::Base
  auditable
end

describe TestModel do
  
  context 'its class should be auditable' do
    subject { TestModel }

    it 'contains a auditable method' do
      subject.should respond_to(:auditable)
    end
  end

  context 'default save callback behavior'
end
